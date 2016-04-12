//
//  YTCookKindItem.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/22.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTCookKindItem.h"

@implementation YTCookKindItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"descStr" : @"description",
             @"idStr" : @"id"
             };
}

@end
