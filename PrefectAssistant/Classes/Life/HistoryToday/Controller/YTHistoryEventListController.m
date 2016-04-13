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
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadEventDateFromNetwork {
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"date"] = self.historyDate;
    paramters[@"key"] = @"c5770adc04027151413c7b1437cccc8a";
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://v.juhe.cn/todayOnhistory/queryEvent.php" parameters:paramters  progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self.tableView.mj_header endRefreshing];
         NSMutableArray *historyEvents = [YTHistoryEvent mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
         self.historyEvents = historyEvents;
         [self.tableView reloadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self.tableView.mj_header endRefreshing];
         NSLog(@"error:%@", error);
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
