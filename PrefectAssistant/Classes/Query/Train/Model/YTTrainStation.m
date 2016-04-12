//
//  YTTrainStation.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainStation.h"


@implementation YTTrainStation

- (void)setDeptTime:(NSString *)deptTime {
    
    _deptTime = [deptTime stringByAppendingString:@"出发"];
}

- (void)setArriTime:(NSString *)arriTime {
    _arriTime = [arriTime stringByAppendingString:@"到达"];
}

@end
