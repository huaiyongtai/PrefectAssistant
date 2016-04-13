//
//  YTAddressPickerView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/8.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTAddressPickerView.h"

@implementation YTAddressPickerView

- (void)showPikerView {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGFloat totalHeight = 200;
    [self setFrame:CGRectMake(0, totalHeight, window.width, window.height)];
   
    CGFloat btnH = totalHeight*0.2;
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [confirmBtn setFrame:CGRectMake(0, self.height-btnH, self.width, btnH)];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setBackgroundColor:YTColorQueryButton];
    }
    [self addSubview:confirmBtn];
    
    UIPickerView *picker = [[UIPickerView alloc] init]; {
        CGFloat height = totalHeight*0.8;
        [picker setFrame:CGRectMake(0, confirmBtn.y-height, self.width, totalHeight*0.8)];
        [picker setBackgroundColor:[UIColor whiteColor]];
        [picker setDelegate:self.delegate];
    }
    [self addSubview:picker];
    _picker = picker;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [self setFrame:window.bounds];
    }];
}

- (void)setDelegate:(id<UIPickerViewDelegate,UIPickerViewDataSource, YTAddressPickerViewDelegate>)delegate {
    
    _delegate = delegate;
    
    self.picker.delegate = delegate;
    self.picker.dataSource = delegate;
}

- (void)confirmBtnDidClick {
    
    if ([self.delegate respondsToSelector:@selector(addressPickerDidSelectedQueryAddress:)]) {
        [self.delegate addressPickerDidSelectedQueryAddress:self];
    }
    
    [self dismissView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissView];
}

- (void)dismissView {
    [UIView animateWithDuration:0.3 animations:^{
        self.y += 200;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
