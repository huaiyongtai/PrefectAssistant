//
//  YTTVPlaybill.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTVPlaybill.h"

@implementation YTTVPlaybill

- (void)setTime:(NSString *)time {
    
    _time = [time substringFromIndex:10];
    
}

@end
