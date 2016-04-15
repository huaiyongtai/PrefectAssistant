//
//  YTDish.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/22.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTDish.h"

const CGFloat YTDishHeight = 100;

@implementation YTDish

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"idStr": @"id",
             @"descStr" : @"description"
             };
    
}


@end
