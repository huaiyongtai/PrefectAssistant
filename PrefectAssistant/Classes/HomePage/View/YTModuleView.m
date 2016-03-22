//
//  YTModuleView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/18.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTModuleView.h"

NSInteger const kItemRows = 2;
NSInteger const kItemCols = 2;

@interface YTModuleView ()

@property (nonatomic, strong) UIButton *catalogBtn;
@property (nonatomic, strong) NSMutableArray<UIButton *> *itemBtns;

@end

@implementation YTModuleView

+ (instancetype)moduleVieWithCatalogTitle:(NSString *)catalogTitle
                               itemTitles:(NSArray<NSString *> *)titles
                        itemSelectedBlock:(ItemSelectedBlock)itemBlock {
    
    return [self moduleVieWithCatalogTitle:catalogTitle
                                itemTitles:titles
                      catalogSelectedBlock:nil
                         itemSelectedBlock:itemBlock];
}

+ (instancetype)moduleVieWithCatalogTitle:(NSString *)catalogTitle
                               itemTitles:(NSArray<NSString *> *)titles
                     catalogSelectedBlock:(CatalogSelectedBlock)catalogBlock
                        itemSelectedBlock:(ItemSelectedBlock)itemBlock {
    
    return [self moduleVieWithCatalogTitle:catalogTitle
                                itemTitles:titles
                                themeColor:nil
                      catalogSelectedBlock:catalogBlock
                         itemSelectedBlock:itemBlock];;;
}

+ (instancetype)moduleVieWithCatalogTitle:(NSString *)catalogTitle
                               itemTitles:(NSArray<NSString *> *)titles
                               themeColor:(UIColor *)themeColor
                     catalogSelectedBlock:(CatalogSelectedBlock)catalogBlock
                        itemSelectedBlock:(ItemSelectedBlock)itemBlock {
    
    YTModuleView *moduleView = [[self alloc] init];
    [moduleView catalogTitle:catalogTitle itemTitles:titles themeColor:themeColor];
    moduleView.catalogBlock = catalogBlock;
    moduleView.itemBlock = itemBlock;
    
    return moduleView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    UIButton *catalogBtn = [self addBtn];
    [catalogBtn addTarget:self action:@selector(catalogBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.catalogBtn = catalogBtn;
    
    _itemBtns = [NSMutableArray array];
    for (int index=0; index<(kItemRows*kItemCols); index++) {
        UIButton *itemBtn = [self addBtn];
        [itemBtn setTag:index];
        [itemBtn addTarget:self action:@selector(itemBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [_itemBtns addObject:itemBtn];
    }
    return self;
}

- (UIButton *)addBtn {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    {
        [btn.layer setBorderWidth:0.5f];
        [btn.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    [self addSubview:btn];
    return btn;
}

- (void)catalogTitle:(NSString *)catalogTitle itemTitles:(NSArray<NSString *> *)titles {
    
    [self catalogTitle:catalogTitle itemTitles:titles themeColor:self.themeColor];
}
- (void)catalogTitle:(NSString *)catalogTitle itemTitles:(NSArray<NSString *> *)titles themeColor:(UIColor *)themeColor {
    
    [self.catalogBtn setTitle:catalogTitle forState:UIControlStateNormal];
    [self.itemBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<titles.count) {
            [obj setTitle:titles[idx] forState:UIControlStateNormal];
        } else {
            *stop = YES;
        }
    }];
    
    self.themeColor = themeColor;
}
- (void)setThemeColor:(UIColor *)themeColor {
    
    if (_themeColor == themeColor) return;
    
    _themeColor = themeColor;
    
    [self.catalogBtn setBackgroundColor:themeColor];
    [self.itemBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setBackgroundColor:themeColor];
    }];
}

- (void)catalogBtnDidClick:(UIButton *)catalogBtn {
    
    if (self.catalogBlock) {
        self.catalogBlock(catalogBtn.currentTitle);
    }
}
- (void)itemBtnDidClick:(UIButton *)itemBtn {
    
    if (self.itemBlock) {
        self.itemBlock(itemBtn.tag, itemBtn.currentTitle);
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat margin = 8;
    CGFloat btnW = (self.bounds.size.width - margin*2) / (kItemCols+1);
    CGFloat catalogBtnH = (self.bounds.size.height - margin);
    
    [self.catalogBtn setFrame:CGRectMake(margin, margin, btnW, catalogBtnH)];
    
    CGFloat itemBtnH = (self.bounds.size.height - margin) / kItemRows; //3->rows
    [self.itemBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setFrame:CGRectMake(self.catalogBtn.rightX + btnW*(idx%kItemCols),
                                 margin + itemBtnH*(idx/kItemCols),
                                 btnW,
                                 itemBtnH)];
    }];
}

@end
