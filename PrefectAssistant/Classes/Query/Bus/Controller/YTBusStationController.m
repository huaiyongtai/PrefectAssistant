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

@interface YTBusStationController ()

@property (nonatomic, copy) NSArray *busStations;

@end

@implementation YTBusStationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"公交";
    [self.view setBackgroundColor:YTRandomColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self loadBusDataFromNetwork];
}

- (void)loadBusDataFromNetwork {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"455307040fbad32f14f83169a450db38" forKey:@"key"];
    [parameters setValue:self.address forKey:@"city"];

    NSString *url = nil;
    switch (self.infoType) {
        case YTBusInfoTypeBusLine: {
            [parameters setValue:self.busInfo forKey:@"bus"];
            url = @"http://op.juhe.cn/189/bus/busline";
            break;
        }
        case YTBusInfoTypeBusStation: {
            url = @"http://op.juhe.cn/189/bus/station";
            [parameters setValue:self.busInfo forKey:@"station"];
            break;
        }
    }
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:url parameters:parameters  progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         self.busStations = [YTBusStation mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
         [self.tableView reloadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"error:%@", error);
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
