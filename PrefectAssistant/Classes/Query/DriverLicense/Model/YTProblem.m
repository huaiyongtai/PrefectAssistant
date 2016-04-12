//
//  YTProblem.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/31.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTProblem.h"

@implementation YTProblem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"idStr" : @"id"};
}

- (void)setItem1:(NSString *)item1 {
    
    _item1 = [item1 copy];
    if (!item1.length) {
        _item1 = @"正确";
    }
}

- (void)setItem2:(NSString *)item2 {
    
    _item2 = [item2 copy];
    if (!item2.length) {
        _item2 = @"错误";
    }
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    self.completeState = YTProblemCompleteStateUnchoice;
}

@end
