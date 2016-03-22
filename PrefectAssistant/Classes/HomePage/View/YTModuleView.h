//
//  YTModuleView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/18.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemSelectedBlock)(NSInteger index, NSString *title);
typedef void(^CatalogSelectedBlock)(NSString *title);

@interface YTModuleView : UIView

+ (instancetype)moduleVieWithCatalogTitle:(NSString *)catalogTitle
                               itemTitles:(NSArray <NSString *> *)titles
                        itemSelectedBlock:(ItemSelectedBlock)itemBlock;

+ (instancetype)moduleVieWithCatalogTitle:(NSString *)catalogTitle
                               itemTitles:(NSArray <NSString *> *)titles
                     catalogSelectedBlock:(CatalogSelectedBlock)catalogBlock
                        itemSelectedBlock:(ItemSelectedBlock)itemBlock;

+ (instancetype)moduleVieWithCatalogTitle:(NSString *)catalogTitle
                               itemTitles:(NSArray <NSString *> *)titles
                               themeColor:(UIColor *)themeColor
                     catalogSelectedBlock:(CatalogSelectedBlock)catalogBlock
                        itemSelectedBlock:(ItemSelectedBlock)itemBlock;


- (void)catalogTitle:(NSString *)catalogTitle itemTitles:(NSArray <NSString *> *)titles;
- (void)catalogTitle:(NSString *)catalogTitle itemTitles:(NSArray <NSString *> *)titles themeColor:(UIColor *)themeColor;
@property (nonatomic, copy) ItemSelectedBlock itemBlock;
@property (nonatomic, copy) CatalogSelectedBlock catalogBlock;
@property (nonatomic, strong) UIColor *themeColor;

@end
