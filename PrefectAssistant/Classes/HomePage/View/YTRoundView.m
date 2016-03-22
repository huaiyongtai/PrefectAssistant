//
//  YTRoundView.m
//  A-4-HYTRoundView(轮播图)
//
//  Created by HelloWorld on 16/3/14.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTRoundView.h"
#import <UIImageView+WebCache.h>

@interface YTRoundCell : UICollectionViewCell

- (void)adImageInfo:(id)adImageInfo;
- (void)adImageInfo:(id)adImageInfo adTitle:(NSString *)adTitle;

@property (nonatomic, weak  ) UIImageView *adImageView;
@property (nonatomic, strong) UIImage     *imagePlaceholder;
@property (nonatomic, weak  ) UILabel     *adLabelView;
@property (nonatomic, strong) UIColor     *titleBackgroundColor;

@end

@implementation YTRoundCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.adImageView = imageView;
    
    UILabel *adLabelView = [[UILabel alloc] init];
    [adLabelView setTextAlignment:NSTextAlignmentCenter];
    [adLabelView setTextColor:[UIColor whiteColor]];
    [self addSubview:adLabelView];
    self.adLabelView = adLabelView;
    
    return self;
}
- (void)adImageInfo:(id)adImageInfo {
    [self adImageInfo:adImageInfo adTitle:nil];
}
- (void)adImageInfo:(id)adImageInfo adTitle:(NSString *)adTitle {
    
    //设置adImage
    if ([adImageInfo isKindOfClass:[UIImage class]]) {  //UIImage
        [self.adImageView setImage:adImageInfo];
    } else if ([adImageInfo isKindOfClass:[NSString class]]) {  //URLString 或者 imageNamed
        if ([adImageInfo hasPrefix:@"http://"]
            || [adImageInfo hasPrefix:@"https://"]) {
            [self.adImageView sd_setImageWithURL:[NSURL URLWithString:adImageInfo] placeholderImage:self.imagePlaceholder];
        } else {
            [self.adImageView setImage:[UIImage imageNamed:adImageInfo]];
        }
    } else if ([adImageInfo isKindOfClass:[NSURL class]]){  //URL
        [self.adImageView sd_setImageWithURL:adImageInfo placeholderImage:self.imagePlaceholder];
    }
    
    [self.adLabelView setText:adTitle];
    [self.adLabelView setHidden:!adTitle.length];   //无文字隐藏
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.adImageView.frame = self.bounds;
    CGFloat adLabelH = self.bounds.size.height * 0.10 > 30 ? self.bounds.size.height * 10 : 30;
    self.adLabelView.frame = CGRectMake(0, self.bounds.size.height - adLabelH, self.bounds.size.width, adLabelH);
    [self.adLabelView setBackgroundColor:self.titleBackgroundColor];
}

@end;

static NSInteger kBaseNum = 10000;

@interface YTRoundView () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    UIPageControl *_pageControl;
}

@property (nonatomic, weak  ) UICollectionView           *collectionView;
@property (nonatomic, weak  ) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) NSInteger                  currentIndex;
@property (nonatomic, strong) NSTimer                    *timer;

@end

@implementation YTRoundView

+ (instancetype)roundViewWitAdImageInfos:(NSArray *)adImageInfos {
    return [self roundViewWitAdImageInfos:adImageInfos adTitles:nil];
}
+ (instancetype)roundViewWitAdImageInfos:(NSArray *)adImageInfos adTitles:(NSArray<NSString *> *)adTitles {
    return [self roundViewWitAdImageInfos:adImageInfos adTitles:adTitles didSelected:nil];
}
+ (instancetype)roundViewWitAdImageInfos:(NSArray *)adImageInfos
                                adTitles:(NSArray<NSString *> *)adTitles
                             didSelected:(YTRoundViewDidSelectItemBlock)selectedBlock {
    return [self roundViewWitAdImageInfos:adImageInfos adTitles:adTitles scrollVelocity:4.0f didSelected:selectedBlock];
}
+ (instancetype)roundViewWitAdImageInfos:(NSArray *)adImageInfos
                                adTitles:(NSArray<NSString *> *)adTitles
                          scrollVelocity:(NSTimeInterval)scrollVelocity
                             didSelected:(YTRoundViewDidSelectItemBlock)selectedBlock {
    
    YTRoundView *roundView = [[self alloc] init];
    roundView.adImageInfos = adImageInfos;
    roundView.adTitles = adTitles;
    roundView.scrollVelocity = scrollVelocity;
    roundView.selectItemBlock = selectedBlock;
    return roundView;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    _scrollVelocity = 4.0f;
    self.adTitleBackgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                          collectionViewLayout:({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setItemSize:self.bounds.size];
        [flowLayout setMinimumLineSpacing:0];
        self.flowLayout = flowLayout;
        flowLayout;
    })];
    {
        [collectionView setPagingEnabled:YES];
        [collectionView setShowsVerticalScrollIndicator:NO];
        [collectionView setShowsHorizontalScrollIndicator:NO];
        [collectionView registerClass:[YTRoundCell class] forCellWithReuseIdentifier:@"CELL"];
        [collectionView setDataSource:self];
        [collectionView setDelegate:self];
        [collectionView setBackgroundColor:[UIColor blueColor]];
    }
    self.collectionView = collectionView;
    [self addSubview:collectionView];
    
    [self startTimerForScroll];
    
    return self;
}

#pragma mark - Timer
- (void)startTimerForScroll {
    
    if (self.timer == nil) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollVelocity
                                                          target:self
                                                        selector:@selector(scrollToNextAd:)
                                                        userInfo:nil
                                                         repeats:YES];
        self.timer = timer;

    }
    [self.timer fire];
}
- (void)pausedTimerForScroll {
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
//开始调度
- (void)scrollToNextAd:(NSTimer *)timer {
    
    NSInteger toIndex = self.currentIndex+1;
    [self scrollAdImageToIndex:toIndex animated:YES];
}

#pragma mark - UIScrollViewDelegate
//拖动时停止计时器调度
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate distantFuture]];  //计时器停止
}
//拖动结束后计时器调度开始
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    //1.确定是偏移多少个Cell的宽度offsetIndex
    CGFloat distant = (scrollView.contentOffset.x - (self.currentIndex * self.bounds.size.width)) / self.bounds.size.width;
    NSInteger offsetIndex = (NSInteger)(distant>0 ? distant+0.5 : distant-0.5);
    //2.更新当前显示的Cell位置所以
    self.currentIndex += offsetIndex;
    
    //3.开始调度计时器
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollVelocity]];   //计时器开始调度
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.adImageInfos.count * kBaseNum;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YTRoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    NSInteger index = indexPath.item % self.adImageInfos.count;
    id imageInfo = self.adImageInfos[index];
    NSString *title = self.adTitles[index];
    [cell adImageInfo:imageInfo adTitle:title];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectItemBlock) {
        NSInteger index = indexPath.item%self.adImageInfos.count;
        self.selectItemBlock(index, self.adImageInfos[index]);
    }
}

#pragma mark - 滚动
- (void)scrollAdImageToIndex:(NSInteger)index animated:(BOOL)animated {
    
    if (index > [self collectionView:self.collectionView numberOfItemsInSection:0]-1) return;
    self.currentIndex = index;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:animated];
}

#pragma mark -
- (UIPageControl *)pageControl {
    
    if (_pageControl == nil) {
        UIPageControl *pageControl = [[UIPageControl alloc] init]; {
            [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
            [pageControl setPageIndicatorTintColor:[UIColor blackColor]];
            [pageControl setHidesForSinglePage:YES];
        }
        _pageControl = pageControl;
    }
    return _pageControl;

}
- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    _currentIndex = currentIndex;
    [self.pageControl setCurrentPage:currentIndex%self.adImageInfos.count];
}
- (void)setAdImageInfos:(NSArray *)adImageInfos {
    _adImageInfos = adImageInfos;
    if (adImageInfos.count <= 1) {
        [self pausedTimerForScroll];
        kBaseNum = 1;
    } else {
        kBaseNum = 1000;
    }
}

- (void)setShowPageIndicator:(BOOL)showPageIndicator {
    
    _showPageIndicator = showPageIndicator;
    if (showPageIndicator) {
        [self addSubview:self.pageControl];
    } else {
        [_pageControl removeFromSuperview];
    }
}
- (void)setAdImagePlaceholder:(UIImage *)adImagePlaceholder {
    _adImagePlaceholder = adImagePlaceholder;
    
    YTRoundCell *cell = [YTRoundCell appearance];
    [cell setImagePlaceholder:adImagePlaceholder];
}

- (void)setAdTitleBackgroundColor:(UIColor *)adTitleBackgroundColor {
    _adTitleBackgroundColor = adTitleBackgroundColor;
    
    YTRoundCell *cell = [YTRoundCell appearance];
    [cell setTitleBackgroundColor:adTitleBackgroundColor];
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.flowLayout.collectionView.frame = self.bounds;
    self.flowLayout.itemSize = self.bounds.size;
    //初始位置
    [self scrollAdImageToIndex:(self.adImageInfos.count * kBaseNum * 0.5) animated:NO];
    //布局位置
    if (self.adTitles.count) {
        self.showPageIndicator = NO;
    } else {
        [self.pageControl setFrame:CGRectMake(0, self.bounds.size.height-15, self.bounds.size.width, 0)];
        [self.pageControl setNumberOfPages:self.adImageInfos.count];
        [self bringSubviewToFront:self.pageControl];
    }
    
}
@end