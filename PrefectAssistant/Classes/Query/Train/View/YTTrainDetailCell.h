//
//  YTTrainDetailCell.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTTrainDetailCell : UITableViewCell

@property (nonatomic, copy) NSArray<NSString *> *trainRowTimetables;

+ (instancetype)trainDetailCellWithTableView:(UITableView *)tableView;

@end
