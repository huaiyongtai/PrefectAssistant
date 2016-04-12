//
//  YTHistoryPickerView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/5.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTHistoryPickerView;

@protocol YTHistoryPickerViewDelegate <NSObject>

@optional
- (void)historyPickerView:(YTHistoryPickerView *)pickView didSelectedDate:(NSString *)dateString;

@end

@interface YTHistoryPickerView : UIView

- (void)showPicker;
@property (nonatomic, weak) id <YTHistoryPickerViewDelegate>delegate;

@end
