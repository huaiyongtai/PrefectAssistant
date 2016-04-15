//
//  YTHistoryEventListController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTHistoryEventListController.h"
#import "YTHistoryEvent.h"
#import "YTHistoryEventDetailController.h"
#import <MJRefresh.h>

@interface YTHistoryEventListController ()

@property (nonatomic, copy) NSArray *historyEvents;

@end

@implementation YTHistoryEventListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:YTColorBackground];
    
    self.title = [self.historyDate stringByAppendingString:@"-大事件"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadEventDateFromNetwork];
    }];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadEventDateFromNetwork {
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"date"] = self.historyDate;
    paramters[@"key"] = APIHistoryKey;
    
    [YTHTTPTool get:APIHistoryQueryEventQ parameters:paramters success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSArray *resultArray = responseObject[@"result"];
        if (![resultArray isKindOfClass:[NSArray class]]) {
            [YTAlertView showAlertMsg:YTHTTPDataException];
            return;
        }
        if (resultArray.count == 0) {
            [YTAlertView showAlertMsg:YTHTTPDataZero];
            return;
        }
        self.historyEvents = [YTHistoryEvent mj_objectArrayWithKeyValuesArray:resultArray];;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [YTAlertView showAlertMsg:YTHTTPFailure];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.historyEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTHistoryEvent *event = self.historyEvents[indexPath.row];
    
    UITableViewCell *cell = ({
        static NSString *reuseId = @"HistoryCell";
        cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell.textLabel setTextColor:YTColorGrayText];
            [cell.detailTextLabel setNumberOfLines:0];
            [cell.detailTextLabel setTextColor:YTColorTintText];
        }
        cell;
    });
    
    [cell.textLabel setText:event.date];
    [cell.detailTextLabel setText:event.title];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YTHistoryEvent *event = self.historyEvents[indexPath.row];
   
    YTHistoryEventDetailController *eventDetailVC = [[YTHistoryEventDetailController alloc] init];
    eventDetailVC.historyEvent = event;
    [self.navigationController pushViewController:eventDetailVC animated:YES];
}

@end
