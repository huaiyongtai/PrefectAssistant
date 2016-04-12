//
//  YTTrainSeatCell.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTTrainSeat;

extern const CGFloat YTTrainSeatCellH;

@interface YTTrainSeatCell : UITableViewCell

@property (nonatomic, strong) YTTrainSeat *trainSeat;

+ (instancetype)trainSeatWithTableView:(UITableView *)tableView;

@end
