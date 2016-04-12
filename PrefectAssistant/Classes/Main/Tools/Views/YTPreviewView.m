//
//  YTPreviewView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/7.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTPreviewView.h"
#import <UIImageView+WebCache.h>

@interface YTPreviewView ()

@property (nonatomic, assign) CGRect fromRect;

@property (nonatomic, assign) UIImageView *showImgView;

@end

@implementation YTPreviewView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    [self setBackgroundColor:[UIColor blackColor]];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewRemover:)]];
    
    UIImageView *showImgView = [[UIImageView alloc] init]; {
        [showImgView setContentMode:UIViewContentModeScaleAspectFit];
        
    }
    [self addSubview:showImgView];
    _showImgView = showImgView;
    return self;
}

- (void)showImageWithURLString:(NSString *)urlString FromvView:(UIView *)fromView {
    
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    [self setFrame:lastWindow.bounds];
    [lastWindow addSubview:self];
    
    self.fromRect = [fromView convertRect:fromView.bounds toView:lastWindow];
    [self.showImgView setFrame:self.fromRect];
    [self.showImgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.showImgView setFrame:self.bounds];
    }];
}

- (void)previewRemover:(UIGestureRecognizer *)gesture {
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.showImgView setFrame:self.fromRect];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
