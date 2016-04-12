//
//  YTBusLineCell.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTBusLine;

@interface YTBusLineCell : UITableViewCell

@property (nonatomic, strong) YTBusLine *busLine;

+ (instancetype)busLineCellWithTableView:(UITableView *)tableView;

@end
