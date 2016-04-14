//
//  YTAddressPickerView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/8.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTAddressPickerView;

@protocol YTAddressPickerViewDelegate <NSObject>

@optional
- (void)addressPickerDidSelectedQueryAddress:(YTAddressPickerView *)picker;

@end

@interface YTAddressPickerView : UIView

@property (nonatomic, weak) id <UIPickerViewDelegate, UIPickerViewDataSource, YTAddressPickerViewDelegate> delegate;
@property (nonatomic, weak, readonly) UIPickerView *picker;
- (void)showPikerView;
@end
