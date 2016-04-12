//
//  YTTrainStationCell.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat YTTrainStationCellH;

@class YTTrainStation;

@interface YTTrainStationCell : UITableViewCell

@property (nonatomic, strong) YTTrainStation *trainInfo;

+ (instancetype)trainStationWithTableView:(UITableView *)tableView;

@end
