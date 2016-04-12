//
//  YTTrainStationController.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTTrainInfoQuery;

@interface YTTrainStationController : UITableViewController

/** 查询信息的模型 */
@property (nonatomic, strong) YTTrainInfoQuery *trainQuery;


@end
