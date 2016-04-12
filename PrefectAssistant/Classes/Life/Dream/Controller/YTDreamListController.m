//
//  YTDreamListController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTDreamListController.h"
#import "YTDream.h"
#import "YTDreamCell.h"

@interface YTDreamListController ()

@property (nonatomic, copy) NSArray *dreamRuslts;
@end

@implementation YTDreamListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:YTRandomColor];
    
    self.title = self.keyWord;
    
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    
    [self loadDreamDataFromNetwork];

    
}

- (void)loadDreamDataFromNetwork {
    
    NSDictionary *parameters = @{@"key" : @"50d88e8ad11b50b0ab49d119b61e13b0",
                                 @"q"   : @"黄瓜",
                                 @"full": @"1"};
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://v.juhe.cn/dream/query" parameters:parameters  progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

         self.dreamRuslts = [YTDream mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
         [self.tableView reloadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

         NSLog(@"error:%@", error);
     }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dreamRuslts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTDream *dream = self.dreamRuslts[indexPath.row];
    YTDreamCell *cell = [YTDreamCell dreamCellWithTableView:tableView];
    cell.dream = dream;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    YTDream *dream = self.dreamRuslts[indexPath.row];
    return dream.totalHeight;
}


@end
