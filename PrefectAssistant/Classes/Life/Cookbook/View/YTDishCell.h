//
//  YTDishCell.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/23.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTDish;

@interface YTDishCell : UITableViewCell

@property (nonatomic, strong) YTDish *dish;

+ (instancetype)dishCellWithTableView:(UITableView *)tableView;

@end
