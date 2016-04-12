//
//  YTLanguageCode.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/30.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTLanguageCode : NSObject

/**  */
@property (nonatomic, copy) NSString *name;

/** */
@property (nonatomic, copy) NSString *code;

+ (instancetype)languageCodeWithName:(NSString *)name code:(NSString *)code;

@end
