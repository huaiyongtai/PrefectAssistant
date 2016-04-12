//
//  YTBusStationView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTBusStation;

@interface YTBusStationView : UITableViewHeaderFooterView

@property (nonatomic, strong) YTBusStation *busStation;

+ (instancetype)busStationViewWithTableView:(UITableView *)tableView;

@end
