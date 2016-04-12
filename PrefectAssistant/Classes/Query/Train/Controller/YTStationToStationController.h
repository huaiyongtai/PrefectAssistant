//
//  YTStationToStationController.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTTrainInfoQuery;

@interface YTStationToStationController : UITableViewController

/** 查询信息的模型 */
@property (nonatomic, strong) YTTrainInfoQuery *trainQuery;

@end
