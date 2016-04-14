//
//  YTPostCode.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTPostCode.h"

@implementation YTPostCode


//"PostNumber":"677006",
//"Province":"云南省",
//"City":"临沧市",
//"District":"临翔区",
//"Address":"马台乡平河村"
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"postNumber" : @"PostNumber",
             @"province"   : @"Province",
             @"city"       : @"City",
             @"district"   : @"District",
             @"address"    : @"Address"};
    
}

@end
