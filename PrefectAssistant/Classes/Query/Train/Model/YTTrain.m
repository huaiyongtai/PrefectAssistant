//
//  YTTrain.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrain.h"
#import "YTTrainSeat.h"

@implementation YTTrain

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"seatInfos" : [YTTrainSeat class]};
}

- (void)setTrainType:(NSString *)trainType {
    
    NSString *tempString = nil;
    if ([trainType isEqualToString:@"空调特快"]) {
        tempString = @"特快";
    } else if ([trainType isEqualToString:@"高速动车"]) {
        tempString = @"高铁";
    } else if ([trainType isEqualToString:@"快速"]) {
        tempString = @"快速";
    } else if ([trainType isEqualToString:@"直达特快"]) {
        tempString = @"直达";
    } else  {
        tempString = trainType;
    }
    
    _trainType = tempString;
}

@end
