//
//  YTMenuContentView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/24.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTMenuContentView.h"
#import "YTTrainInfoQuery.h"
#import "YTTrainQueryItemBtn.h"

@interface YTMenuContentView ()

@property (nonatomic, strong) NSMutableArray<YTTrainQueryItemBtn *> *itemViews;

@end

@implementation YTMenuContentView

+ (instancetype)memuContentViewWithQueryItems:(NSArray *)items didClickItem:(ContentItemDidClickBlock)block {
    
    YTMenuContentView *contentView = [[self alloc] init];
    contentView.queryItems = items;
    contentView.itemBlock = block;
    
    return contentView;
}

- (NSMutableArray<YTTrainQueryItemBtn *> *)itemViews {
    
    if (_itemViews == nil) {
        _itemViews = [NSMutableArray array];
    }
    return _itemViews;
    
}

- (void)setQueryItems:(NSArray<YTTrainInfoQuery *> *)queryItems {
    
    _queryItems = [queryItems copy];
    
    while (queryItems.count>self.itemViews.count) {
        YTTrainQueryItemBtn *itemBtn = [YTTrainQueryItemBtn buttonWithType:UIButtonTypeCustom]; {
            [itemBtn addTarget:self action:@selector(itemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:itemBtn];
        [self.itemViews addObject:itemBtn];
    }
    
    [self.itemViews enumerateObjectsUsingBlock:^(YTTrainQueryItemBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.queryItems.count) {
            obj.hidden = YES;
        } else {
            obj.hidden = NO;
            obj.query = queryItems[idx];;
        }
    }];
}

- (void)itemDidClick:(YTTrainQueryItemBtn *)itemBtn {
    
    if (self.itemBlock) {
        self.itemBlock(itemBtn.query);
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat itemH = self.height / self.queryItems.count;
    CGFloat itemW = self.width;
    [self.itemViews enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx >= self.queryItems.count) {
            *stop = YES;
        } else {
            [obj setFrame:CGRectMake(0, itemH*idx, itemW, itemH)];
        }
    }];
}

@end
