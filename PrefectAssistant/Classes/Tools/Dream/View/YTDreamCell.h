//
//  YTDreamCell.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTDream;

@interface YTDreamCell : UITableViewCell

@property (nonatomic, strong) YTDream *dream;

+ (instancetype)dreamCellWithTableView:(UITableView *)tableView;

@end
