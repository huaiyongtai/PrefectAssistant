//
//  YTTVPlaybillController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTVPlaybillController.h"
#import "YTTVPlaybill.h"
#import "YTTVShow.h"
#import <MJRefresh.h>

@interface YTTVPlaybillController ()

@property (nonatomic, strong) NSArray *tvPlaybills;

@end

@implementation YTTVPlaybillController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.tvShow.channelName;

    [self.tableView setBackgroundColor:YTColorBackground];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadTVPlaybillFromNetwork];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadTVPlaybillFromNetwork {
    NSDictionary *parameters = @{@"key" : APITVKey,
                                 @"code" : self.tvShow.rel};
    
    [YTHTTPTool get:APITVProgramQ parameters:parameters success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        
        NSArray *resultArray = responseObject[@"result"];
        if (!([resultArray isKindOfClass:[NSArray class]] && resultArray.count)) {
            [YTAlertView showAlertMsg:YTHTTPDataException];
            return;
        }
        if (resultArray.count == 0) {
            [YTAlertView showAlertMsg:YTHTTPDataZero];
            return;
        }
        self.tvPlaybills = [YTTVPlaybill mj_objectArrayWithKeyValuesArray:resultArray];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [YTAlertView showAlertMsg:YTHTTPFailure];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tvPlaybills.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTTVPlaybill *tvPlaybill = self.tvPlaybills[indexPath.row];
    
    static NSString *reuseId = @"YTTVShow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.textLabel.text = tvPlaybill.time;
    cell.detailTextLabel.text = tvPlaybill.pName;
    
    return cell;
}




@end
