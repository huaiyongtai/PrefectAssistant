//
//  YTChannelListController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTChannelListController.h"
#import "YTTVPlaybillController.h"
#import "YTTVShow.h"
#import <MJRefresh.h>

@interface YTChannelListController ()

@property (nonatomic, strong) NSArray *tvShows;

@end

@implementation YTChannelListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @[@"央视", @"卫视", @"数字", @"城市", @"CETV", @"原创"][[self.categoryId intValue]-1];
    
    [self.tableView setBackgroundColor:YTRandomColor];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadTVPlaybillFromNetwork];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadTVPlaybillFromNetwork {
    NSDictionary *parameters = @{@"key" : @"059cb6397da1481fa2221fe60a3c9dfa",
                                 @"pId" : self.categoryId};
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://japi.juhe.cn/tv/getChannel" parameters:parameters  progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        self.tvShows = [YTTVShow mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"error:%@", error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tvShows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTTVShow *tvShow= self.tvShows[indexPath.row];
    
    static NSString *reuseId = @"YTTVShow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    cell.textLabel.text = tvShow.channelName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YTTVShow *tvShow = self.tvShows[indexPath.row];
    YTTVPlaybillController *palyBillVC = [[YTTVPlaybillController alloc] init];
    palyBillVC.tvShow = tvShow;
    [self.navigationController pushViewController:palyBillVC animated:YES];
}

@end
