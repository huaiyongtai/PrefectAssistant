//
//  YTStationToStationController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTStationToStationController.h"
#import "YTTrain.h"
#import "YTTrainSeat.h"
#import "YTTrainHeaderView.h"
#import "YTTrainSeatCell.h"
#import "YTTrainNumberController.h"
#import "YTTrainInfoQuery.h"
#import <MJRefresh.h>

@interface YTStationToStationController () <YTTrainHeaderViewDelegate>

@property (nonatomic, copy) NSArray<YTTrain *> *trains;

@end

@implementation YTStationToStationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; //使用自己的分割线
    
    [self.navigationItem setTitleView:({
        UIButton *navTitile = [UIButton buttonWithType:UIButtonTypeCustom]; {
            [navTitile setTitle:({
                [self.trainQuery.startStation stringByAppendingFormat:@" <—> %@", self.trainQuery.endStation];
            }) forState:UIControlStateNormal];
            [navTitile setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [navTitile setFrame:CGRectMake(0, 0, 50, 35)];
            [navTitile addTarget:self action:@selector(exchengTrainStation:) forControlEvents:UIControlEventTouchUpInside];
        }
        navTitile;
    
    })];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadTrainStationToStationInfoFromNetwork];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)exchengTrainStation:(UIButton *)navTitile {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                     message:@"确定交换发到站吗？"
                                                              preferredStyle:UIAlertControllerStyleAlert]; {
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      NSString *tempString = self.trainQuery.startStation;
                                                      self.trainQuery.startStation = self.trainQuery.endStation;
                                                      self.trainQuery.endStation = tempString;
                                                      [navTitile setTitle:({
                                                          [self.trainQuery.startStation stringByAppendingFormat:@" <—> %@", self.trainQuery.endStation];
                                                      }) forState:UIControlStateNormal];
                                                      [self.tableView.mj_header beginRefreshing];
                                                  }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消"
                                                    style:UIAlertActionStyleDefault
                                                  handler:nil]];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)loadTrainStationToStationInfoFromNetwork {

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"1.0" forKey:@"version"];
    [parameters setObject:self.trainQuery.startStation forKey:@"from"];
    [parameters setObject:self.trainQuery.endStation forKey:@"to"];
    [parameters setObject:self.trainQuery.departedTime forKey:@"date"];
   
    [YTHTTPTool bdGet:APITrainStationToStationQ parameters:parameters success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSArray *resultArray = responseObject[@"data"][@"trainList"];
        if (!([resultArray isKindOfClass:[NSArray class]] && resultArray.count)) {
            [YTAlertView showAlertMsg:YTHTTPDataException];
            return;
        }
        if (resultArray.count == 0) {
            [YTAlertView showAlertMsg:YTHTTPDataZero];
            return;
        }
        self.trains = [YTTrain mj_objectArrayWithKeyValuesArray:resultArray];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [YTAlertView showAlertMsg:YTHTTPFailure];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.trains.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YTTrain *train = self.trains[section];
    if (train.isRevealSeatInfos) {
        return train.seatInfos.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTTrainSeat *seat = self.trains[indexPath.section].seatInfos[indexPath.row];
    
    YTTrainSeatCell *cell = [YTTrainSeatCell trainSeatWithTableView:tableView];
    cell.trainSeat = seat;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YTTrainSeatCellH;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    YTTrain *train = self.trains[section];
    YTTrainHeaderView *headerView = [YTTrainHeaderView trainHeaderViewWith:tableView];
    headerView.delegate = self;
    headerView.train = train;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return YTTrainHeaderViewH;
}

#pragma mark - YTTrainHeaderViewDelegate
- (void)trainHeaderView:(YTTrainHeaderView *)headerView didSelectedTrainNumber:(NSString *)trainNo {
    
    YTTrainInfoQuery *query = [[YTTrainInfoQuery alloc] init];
    query.trainNo = trainNo;
    query.departedTime = self.trainQuery.departedTime;
    
    YTTrainNumberController *trainNumVC = [[YTTrainNumberController alloc] init];
    trainNumVC.trainQuery = query;
    [self.navigationController pushViewController:trainNumVC animated:YES];
}

- (void)trainHeaderView:(YTTrainHeaderView *)headerView train:(YTTrain *)train didShowRevealseatInfos:(BOOL)isReveal {
    
    train.revealSeatInfos = isReveal;
    [self.tableView reloadData];
}

@end
