//
//  UINavigationBar+Extension.h
//  YTNavBar
//
//  Created by 无法修盖 on 16/5/9.
//  Copyright © 2016年 无法修盖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Extension)

- (UIView *)contentView;

/**
 *  设置bar的背景颜色,即Bar的整体颜色
 */
- (void)setBarBackgroundColor:(UIColor *)barColor;

/**
 *  设置当前ViewController的上Bar的颜色，将不会不影响其他Controller的bar的颜色
 */
- (void)setViewController:(UIViewController *)viewController barBackgroundColor:(UIColor *)barColor;

@end
