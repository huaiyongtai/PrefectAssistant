//
//  YTCookKindView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/23.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTCookKindItem;

typedef void(^CookItemDidClickBlock)(YTCookKindItem *kindItem);

@interface YTCookKindView : UIView

/** 列数 */
@property (nonatomic, assign) NSUInteger cols;

/** 菜品种类模型数组 */
@property (nonatomic, copy) NSArray <YTCookKindItem *> *kindItems;

/** 菜品种类点击回到 */
@property (nonatomic, copy) CookItemDidClickBlock kindItemBlock;
+ (instancetype)cookKindViewWithShowCols:(NSInteger)cols didClickItem:(CookItemDidClickBlock)block;;
+ (instancetype)cookKindViewWithKindItems:(NSArray *)kindItems showCols:(NSInteger)cols didClickItem:(CookItemDidClickBlock)block;

@end
