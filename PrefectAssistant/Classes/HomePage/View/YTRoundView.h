//
//  YTRoundView.h
//  A-4-HYTRoundView(轮播图)
//
//  Created by HelloWorld on 16/3/14.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^YTRoundViewDidSelectItemBlock)(NSInteger index, id adInfo);

@interface YTRoundView : UIView

/**
 *  图片信息数组（数组存放imageName或UIImage或URL或URLString）
 */
@property (nonatomic, copy) NSArray *adImageInfos;
@property (nonatomic, strong) UIImage *adImagePlaceholder;
/**
 *  标题数组（当设置为nil时默认不显示）
 */
@property (nonatomic, copy) NSArray<NSString*> *adTitles;
/**
 *  标题的背景颜色 默认[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]
 */
@property (nonatomic, strong) UIColor *adTitleBackgroundColor;

/**
 *  图片指示器
 */
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
/**
 *  是否显示图片指示器
 */
@property (nonatomic, assign) BOOL showPageIndicator;

/**
 *  滚动速度 默认4.0s
 */
@property (nonatomic, assign) NSTimeInterval scrollVelocity;

/**
 *  选择滚动视回调Block
 */
@property (nonatomic, copy) YTRoundViewDidSelectItemBlock selectItemBlock;

/**
 *  启动定时器开始滚动，默认 定时器是开启的
 */
- (void)startTimerForScroll;

/**
 *  停止定时器。当要停止滚动时，你总是应该调用次方法来告知定时器。
 */
- (void)pausedTimerForScroll;

/**
 *  快速工厂方法
 *  @param adImageInfos   图片片信息数组（可以是NSString、UIImage、NSURL）
 *  @param adTitles       标题数组
 *  @param scrollVelocity 滚动速率
 *  @param selectedBlock  点击图片的回调方法
 */
+ (instancetype)roundViewWitAdImageInfos:(NSArray *)adImageInfos;
+ (instancetype)roundViewWitAdImageInfos:(NSArray *)adImageInfos
                                     adTitles:(NSArray<NSString *>*)adTitles;
+ (instancetype)roundViewWitAdImageInfos:(NSArray *)adImageInfos
                                     adTitles:(NSArray<NSString *>*)adTitles
                                  didSelected:(YTRoundViewDidSelectItemBlock)selectedBlock;
+ (instancetype)roundViewWitAdImageInfos:(NSArray *)adImageInfos
                                     adTitles:(NSArray<NSString *>*)adTitles
                               scrollVelocity:(NSTimeInterval)scrollVelocity
                                  didSelected:(YTRoundViewDidSelectItemBlock)selectedBlock;
@end
