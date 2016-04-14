//
//  YTTrainNumberController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainNumberController.h"
#import "YTTrainDetailCell.h"
#import "YTTrainInfoQuery.h"
#import "YTTrainDetailView.h"
#import <MJRefresh.h>

@interface YTTrainNumberController ()

@property (nonatomic, copy) NSArray *trainNumberInfoArray;
@property (nonatomic, copy) NSArray *headerSectionData;

@property (nonatomic, weak) UILabel *startStaionLabel;
@property (nonatomic, weak) UILabel *endStaionLabel;
@property (nonatomic, weak) UILabel *durationLabel;

@end

@implementation YTTrainNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"车次详情";
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadTrainNumberInfoFromNetwork];
    }];
    [self.tableView.mj_header beginRefreshing];

    [self.tableView setTableHeaderView:[self setupHeaderView]]; ;
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void)loadTrainNumberInfoFromNetwork {
   
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"1.0" forKey:@"version"];
    [parameters setObject:self.trainQuery.trainNo forKey:@"train"];
    [parameters setObject:self.trainQuery.departedTime forKey:@"date"];
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer setValue:APIKEY forHTTPHeaderField:@"apikey"];
    [mgr GET:APITrainNumberQ parameters:parameters  progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        self.trainNumberInfoArray = responseObject[@"data"][@"info"][@"value"];
        self.headerSectionData = responseObject[@"data"][@"info"][@"head"];
        [self setHeaderInfoWithDict:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (UIView *)setupHeaderView {
    
    UIView *headerView = [[UIView alloc] init]; {
        [headerView setHeight:80];
        [headerView setBackgroundColor:YTColorBackground];
        CGFloat margin = 10;
        CGFloat width = (YTSCREEN_W - 2*margin) / 3;
        CGFloat height = headerView.height;
        
        //左
        UILabel *startStaionLabel = [[UILabel alloc] init]; {
            [startStaionLabel setFrame:CGRectMake(margin, 0, width, height)];
            [startStaionLabel setTextAlignment:NSTextAlignmentCenter];
            [startStaionLabel setNumberOfLines:0];
        }
        self.startStaionLabel = startStaionLabel;
        [headerView addSubview:startStaionLabel];
        
        //右
        UILabel *endStaionLabel = [[UILabel alloc] init]; {
            [endStaionLabel setFrame:CGRectMake(margin+2*width, 0, width, height)];
            [endStaionLabel setTextAlignment:NSTextAlignmentCenter];
            [endStaionLabel setNumberOfLines:0];
        }
        self.endStaionLabel = endStaionLabel;
        [headerView addSubview:endStaionLabel];
        
        //中间
        CGFloat centerH = (height - 2*margin) / 3;
        CGFloat adjustH = 5;
        UILabel *trainNoLabel = [[UILabel alloc] init]; {
            [trainNoLabel setFrame:CGRectMake(startStaionLabel.rightX, margin, width, centerH+adjustH)];
            [trainNoLabel setText:self.trainQuery.trainNo];
            [trainNoLabel setTextAlignment:NSTextAlignmentCenter];
        }
        [headerView addSubview:trainNoLabel];
        UIImageView *directionImageView = [[UIImageView alloc] init]; {
            [directionImageView setImage:[UIImage imageNamed:@"direction"]];
            [directionImageView setFrame:CGRectMake(trainNoLabel.x, trainNoLabel.bottomY, width, centerH-2*adjustH)];
        }
        [headerView addSubview:directionImageView];
        UILabel *durationLabel = [[UILabel alloc] init]; {
            [durationLabel setFrame:CGRectMake(trainNoLabel.x, directionImageView.bottomY, width, centerH+adjustH)];
            [durationLabel setTextAlignment:NSTextAlignmentCenter];
        }
        self.durationLabel = durationLabel;
        [headerView addSubview:durationLabel];
    }
    return headerView;
}

- (void)setHeaderInfoWithDict:(NSDictionary *)dict {
    
    if (!dict.count) return;
    
    self.durationLabel.text = dict[@"extInfo"][@"totalTime"];
    
    [self.startStaionLabel setAttributedText:({
        NSArray *startStationArray = [dict[@"info"][@"value"] firstObject];
        NSString *startStationName = startStationArray[1];
        NSString *startStationTime = startStationArray[4];
        NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc]
                                                 initWithString:[startStationName stringByAppendingFormat:@"\n%@", startStationTime]];
        [mAttString setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}
                            range:NSMakeRange(0, startStationName.length)];
        mAttString;
    })];
    
    [self.endStaionLabel setAttributedText:({
        NSArray *endStationArray = [dict[@"info"][@"value"] lastObject];
        NSString *endStationName = endStationArray[1];
        NSString *endStationTime = endStationArray[3];
        NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc]
                                                 initWithString:[endStationName stringByAppendingFormat:@"\n%@", endStationTime]];
        [mAttString setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}
                            range:NSMakeRange(0, endStationName.length)];
        mAttString;
    })];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.trainNumberInfoArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *trainRowTimetables = self.trainNumberInfoArray[indexPath.row];
    YTTrainDetailCell *cell = [YTTrainDetailCell trainDetailCellWithTableView:tableView];
    cell.trainRowTimetables = trainRowTimetables;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 25;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"累死我了，还有毕业设计要做，哎";
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    YTTrainDetailView *headerSection = [YTTrainDetailView trainDetailView];
    headerSection.trainRowTimetables = self.headerSectionData;
    return headerSection;
}
@end
