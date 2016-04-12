//
//  YTMenuContentView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/24.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTTrainInfoQuery;

typedef void(^ContentItemDidClickBlock)(YTTrainInfoQuery *trainQuery);

@interface YTMenuContentView : UIView

/** 查询模型数组 */
@property (nonatomic, copy) NSArray <YTTrainInfoQuery *> *queryItems;

/** 点击回到 */
@property (nonatomic, copy) ContentItemDidClickBlock itemBlock;

+ (instancetype)memuContentViewWithQueryItems:(NSArray<YTTrainInfoQuery *> *)items
                                 didClickItem:(ContentItemDidClickBlock)block;

@end
