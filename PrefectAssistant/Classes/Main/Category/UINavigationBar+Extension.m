//
//  UINavigationBar+Extension.m
//  YTNavBar
//
//  Created by 无法修盖 on 16/5/9.
//  Copyright © 2016年 无法修盖. All rights reserved.
//

#import "UINavigationBar+Extension.h"
#import <objc/runtime.h>

static const void *backgroundViewKey = "backgroundViewKey";                 //bar视图Key
static const void *barAllBackgroundColorsKey = "barAllBackgroundColorsKey"; //bar背景色数组
static const void *contentViewKey = "contentViewKey";                       //bar背景色数组
static NSString *barBackgroundColorKey = @"barBackgroundKey";               //bar背景颜色key

@implementation UINavigationBar (Extension)

//模拟懒加载
- (UIView *)backgroundView {
    
    if (objc_getAssociatedObject(self, &backgroundViewKey) == nil) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                [obj setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.85f]];
                objc_setAssociatedObject(self, &backgroundViewKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                *stop = YES;
            }
        }];
    }
    return objc_getAssociatedObject(self, &backgroundViewKey);
}
- (NSMutableDictionary *)barAllBackgroundColor {
    if (objc_getAssociatedObject(self, &barAllBackgroundColorsKey) == nil) {
        NSMutableDictionary *barAllBackgroundColor = [NSMutableDictionary dictionary];
        [barAllBackgroundColor setObject:[[self backgroundView] backgroundColor] forKey:barBackgroundColorKey];
        objc_setAssociatedObject(self, &barAllBackgroundColorsKey, barAllBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, &barAllBackgroundColorsKey);
}

- (UIView *)contentView {
    
    UIView *contentView = objc_getAssociatedObject(self, &contentViewKey);
    if (contentView == nil) {
        contentView = [[UIView alloc] init]; {
            CGFloat contentH = CGRectGetHeight(self.bounds);
            [contentView setFrame:CGRectMake(0,CGRectGetHeight([self backgroundView].bounds) - contentH, CGRectGetWidth(self.bounds), contentH)];
            [contentView setBackgroundColor:[UIColor clearColor]];
        }
        objc_setAssociatedObject(self, &contentViewKey, contentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return contentView;
}

- (void)setBarBackgroundColor:(UIColor *)barColor {

    //1. 去掉背景图片和底部线条
    [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[[UIImage alloc] init]];
    
    //2. 重置数组中bar的背景色
    [[self barAllBackgroundColor] setValue:barColor forKey:barBackgroundColorKey];
    
    //3. 设置背景色
    [[self backgroundView] setBackgroundColor:barColor];
}

//当设置当前控制颜色的时候，将开始拦截所有的Push、Pop操作
- (void)setViewController:(UIViewController *)viewController barBackgroundColor:(UIColor *)barColor {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(popNavigationItemAnimated:)),
                                       class_getInstanceMethod([self class], @selector(yt_popNavigationItemAnimated:)));

        //经测 Push时这个方法系统不会调用不会被调用-(void)pushNavigationItem:animated，调用的是-(void)pushNavigationItem:这个方法
        method_exchangeImplementations(class_getInstanceMethod([self class], NSSelectorFromString(@"pushNavigationItem:")),
                                       class_getInstanceMethod([self class], @selector(yt_pushNavigationItem:)));
    });
    
    [[self barAllBackgroundColor] setValue:barColor forKey:viewController.description];
}

- (void)yt_pushNavigationItem:(UINavigationItem *)item {
    
    [self yt_pushNavigationItem:item];
    [[self backgroundView] setBackgroundColor:({
        UIColor *backgroundColor = [[self barAllBackgroundColor] objectForKey:item.description];
        backgroundColor;
    })];
}
- (UINavigationItem *)yt_popNavigationItemAnimated:(BOOL)animated {
    
    //1. 删除庸余的keyValue（popTo....时）
    [[self barAllBackgroundColor] removeObjectsForKeys:({
        NSArray *filteredArray = [[self.items valueForKey:@"description"] arrayByAddingObject:barBackgroundColorKey];
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",filteredArray];
        [[[self barAllBackgroundColor] allKeys] filteredArrayUsingPredicate:filterPredicate];
    })];
    
    UIColor *preColor = [[self barAllBackgroundColor] objectForKey:self.items[self.items.count-2].description]; //此时的items.count>=2
    if (preColor) {
        [[self backgroundView] setBackgroundColor:preColor];
    } else {
        [[self backgroundView] setBackgroundColor:[[self barAllBackgroundColor] objectForKey:barBackgroundColorKey]];
    }
    return [self yt_popNavigationItemAnimated:animated];
}
@end
