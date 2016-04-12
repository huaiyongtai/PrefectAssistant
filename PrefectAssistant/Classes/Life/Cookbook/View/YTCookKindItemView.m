//
//  YTCookKindItemView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/23.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTCookKindItemView.h"
#import "YTCookKindItem.h"

@implementation YTCookKindItemView

+ (instancetype)cookKindItemView {
    
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    [self setBackgroundColor:YTRandomColor];
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    return self;
}

- (void)setCookKindItem:(YTCookKindItem *)cookKindItem {
    
    _cookKindItem = cookKindItem;
    
    [self setTitle:cookKindItem.name forState:UIControlStateNormal];
    
}

@end
