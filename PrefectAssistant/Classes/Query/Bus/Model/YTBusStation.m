//
//  YTBusStation.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTBusStation.h"
#import "YTBusLine.h"

const CGFloat YTBusStationHeight = 60;

@implementation YTBusStation

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    
    return [propertyName mj_underlineFromCamel];
}

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"stationdes" : [YTBusLine class]};
    
}

@end
