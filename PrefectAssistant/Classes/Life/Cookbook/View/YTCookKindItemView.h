//
//  YTCookKindItemView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/23.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTCookKindItem;

@interface YTCookKindItemView : UIButton

+ (instancetype)cookKindItemView;
/** 菜品分类模型 */
@property (nonatomic, strong) YTCookKindItem *cookKindItem;

@end
