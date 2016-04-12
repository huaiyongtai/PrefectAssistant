//
//  YTTrainQueryItemBtn.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainQueryItemBtn.h"
#import "YTTrainInfoQuery.h"

@implementation YTTrainQueryItemBtn

- (void)setQuery:(YTTrainInfoQuery *)query {
    
    _query = query;
    
    [self setTitle:query.queryName forState:UIControlStateNormal];
    
}

@end
