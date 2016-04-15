//
//  YTBusStationController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTBusStationController.h"
#import "YTBusStationView.h"
#import "YTBusLineCell.h"
#import "YTBusStation.h"
#import "YTBusLine.h"
#import <MJRefresh.h>

@interface YTBusStationController ()

@property (nonatomic, copy) NSArray *busStations;

@end

@implementation YTBusStationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"公交";
    [self.view setBackgroundColor:YTColorBackground];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setMj_header:[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadBusDataFromNetwork];
    }]];
    [self.tableView.mj_header beginRefreshing];
    [self loadBusDataFromNetwork];
}

- (void)loadBusDataFromNetwork {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:APIBusKey forKey:@"key"];
    [parameters setValue:self.address forKey:@"city"];

    NSString *url = nil;
    switch (self.infoType) {
        case YTBusInfoTypeBusLine: {
            [parameters setValue:self.busInfo forKey:@"bus"];
            url = APIBusLineQ;
            break;
        }
        case YTBusInfoTypeBusStation: {
            url = APIBusStationQ;
            [parameters setValue:self.busInfo forKey:@"station"];
            break;
        }
    }
    
    [YTHTTPTool get:url parameters:parameters success:^(id responseObject) {
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
        
        self.busStations = [YTBusStation mj_objectArrayWithKeyValuesArray:resultArray];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [YTAlertView showAlertMsg:YTHTTPFailure];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.busStations.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    YTBusStation *busStation = self.busStations[section];
    return busStation.stationdes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    YTBusStation *busStation = self.busStations[indexPath.section];
    YTBusLine *busLine = busStation.stationdes[indexPath.row];

    YTBusLineCell *cell = [YTBusLineCell busLineCellWithTableView:tableView];
    cell.busLine = busLine;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YTBusLineHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    YTBusStation *busStation = self.busStations[section];
    
    YTBusStationView *headerView = [YTBusStationView busStationViewWithTableView:tableView];
    headerView.busStation = busStation;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return YTBusStationHeight;
}




@end
