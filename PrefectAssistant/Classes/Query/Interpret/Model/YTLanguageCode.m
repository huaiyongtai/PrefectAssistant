//
//  YTLanguageCode.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/30.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTLanguageCode.h"

@implementation YTLanguageCode

+ (instancetype)languageCodeWithName:(NSString *)name code:(NSString *)code {
    
    
    YTLanguageCode *language = [[self alloc] init];
    language.name = name;
    language.code = code;
    
    return language;
}

@end
