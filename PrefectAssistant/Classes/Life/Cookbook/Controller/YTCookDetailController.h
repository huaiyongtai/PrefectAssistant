//
//  YTCookDetailController.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/24.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTDish;

@interface YTCookDetailController : UIViewController

@property (nonatomic, strong) YTDish *dish;

+ (instancetype)cookDetailVCWithDish:(YTDish *)dish;

@end
