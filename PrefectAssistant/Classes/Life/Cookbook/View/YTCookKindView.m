//
//  YTCookKindView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/23.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTCookKindView.h"
#import "YTCookKindItemView.h"

@interface YTCookKindView ()

@property (nonatomic, strong) NSMutableArray<YTCookKindItemView *> *cookKindItemViews;

@end

@implementation YTCookKindView

+(instancetype)cookKindViewWithShowCols:(NSInteger)cols didClickItem:(CookItemDidClickBlock)block {
    return [self cookKindViewWithKindItems:nil showCols:cols didClickItem:block];
}

+ (instancetype)cookKindViewWithKindItems:(NSArray *)kindItems showCols:(NSInteger)cols didClickItem:(CookItemDidClickBlock)block {
    
    YTCookKindView *kindView = [[self alloc] init];
    kindView.kindItems = kindItems;
    kindView.cols = cols;
    kindView.kindItemBlock = block;
    
    return kindView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    _cols = 3;
    _cookKindItemViews = [NSMutableArray array];
    
    return self;
}

- (void)setKindItems:(NSArray<YTCookKindItem *> *)kindItems {
    
    _kindItems = [kindItems copy];
    
    while (kindItems.count > self.cookKindItemViews.count) {
        
        YTCookKindItemView *itemView = [YTCookKindItemView cookKindItemView];
        {
            [itemView addTarget:self
                         action:@selector(cookKindItemDidClick:)
               forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:itemView];
        [self.cookKindItemViews addObject:itemView];
    }
    
    [self.cookKindItemViews enumerateObjectsUsingBlock:^(YTCookKindItemView *obj, NSUInteger idx, BOOL *stop) {
        BOOL hidden = (idx >= kindItems.count);
        obj.hidden = hidden;
        if (!hidden) {
            obj.cookKindItem = kindItems[idx];
            
        }
    }];
    
    [self setNeedsLayout];
}

- (void)cookKindItemDidClick:(YTCookKindItemView *)kindItemView {
    
    if (self.kindItemBlock) {
        self.kindItemBlock(kindItemView.cookKindItem);
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat margin = 8;    //外边距
    CGFloat padding = margin;   //元素之间的边距
    
    NSInteger totalItems = self.kindItems.count;
    
    NSInteger rows = (totalItems + self.cols -1) / self.cols; //行数
    
    CGFloat width = (self.width - margin*2 - padding*(self.cols-1)) / self.cols;
    CGFloat height = (self.height - margin*2 - padding*(rows-1)) / rows;
 
    [self.cookKindItemViews enumerateObjectsUsingBlock:^(YTCookKindItemView *obj, NSUInteger idx, BOOL *stop) {
       
        if (idx >= totalItems) {
            *stop = YES;
        }
        [obj setFrame:CGRectMake(margin+(padding+width)*(idx%self.cols), margin+(padding+height)*(idx/self.cols), width, height)];
    }];
}
@end
