//
//  YTProvince.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/8.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTProvince.h"

@implementation YTDistrict

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"idString": @"id",
             @"name"    : @"district"};
}


@end



@implementation YTCity

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"idString": @"id",
             @"name"    : @"city",
             @"districts"  : @"district"};
}
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"districts" : [YTDistrict class]};
}

@end



@implementation YTProvince

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"idString": @"id",
             @"name"    : @"province",
             @"cities"  : @"city"};
}
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"cities" : [YTCity class]};
}

@end
