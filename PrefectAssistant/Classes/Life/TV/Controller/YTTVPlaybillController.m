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
    NSDictionary *parameters = @{@"key" : @"059cb6397da1481fa2221fe60a3c9dfa",
                                 @"code" : self.tvShow.rel};
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://japi.juhe.cn/tv/getProgram" parameters:parameters  progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        
        NSArray *resultArray = responseObject[@"result"];
        if ([resultArray isKindOfClass:[NSArray class]]) {
            self.tvPlaybills = [YTTVPlaybill mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"暂无数据,将返回上一级" preferredStyle:UIAlertControllerStyleAlert]; {
                
                [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self.navigationController popViewControllerAnimated:YES];
                                                        }
                                  ]
                 ];
            };
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"error:%@", error);
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
    }
    cell.textLabel.text = tvPlaybill.time;
    cell.detailTextLabel.text = tvPlaybill.pName;
    
    return cell;
}




@end
