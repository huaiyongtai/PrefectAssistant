//
//  YTCookDetail.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/22.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTCookDetail.h"

@implementation YTCookDetail

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"idStr": @"id",
             @"descStr" : @"description"
             };
    
}

//+ (NSDictionary *)mj_objectClassInArray {
//    return @{@"images" : [NSString class]
//             };
//}
//
//+ (NSMutableArray *)mj_objectArrayWithKeyValuesArray:(id)keyValuesArray {
//    
//    NSLog(@"%@", keyValuesArray);
//    
//    return nil;
//}

@end
