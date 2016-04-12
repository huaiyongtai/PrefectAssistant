//
//  YTHistoryPickerView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/5.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTHistoryPickerView.h"

@interface YTHistoryPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, weak) UIPickerView *pickerView;

@property (nonatomic, weak) UIButton *confirmBtn;
@property (nonatomic, weak) UIButton *cancelBtn;

@property (nonatomic, strong) NSMutableArray *months;

@end

@implementation YTHistoryPickerView

- (NSMutableArray *)months {
    
    if (_months == nil) {
        NSMutableArray *month = [NSMutableArray array];
        for (int index = 1; index<13; index++) {
            [month addObject:({
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setObject:[NSString stringWithFormat:@"%i", index] forKey:@"moth"];
                [dict setObject:({
                    NSMutableArray *days = [NSMutableArray array];
                    NSInteger dayLength = 0;
                    if (index == 1 || index == 3 || index == 5 || index == 7 || index == 8 || index == 10  || index == 12) {
                        dayLength = 31;
                    } else if(index == 2) {
                        dayLength = 29;
                    } else {
                        dayLength = 30;
                    }
                    for (int j=1; j<dayLength+1; j++) {
                        [days addObject:[NSString stringWithFormat:@"%i", j]];
                    }
                    days;
                    
                }) forKey:@"days"];
                dict;
            })];
        }
        _months = month;
    }
    return _months;
}

- (void)showPicker {
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    
    self.frame = lastWindow.bounds;
    self.bottomY = self.height;
    [lastWindow addSubview:self];
    
    CGFloat btnH = 40;
    CGFloat pickerViewH = 180;
    UIPickerView *pickerView = [[UIPickerView alloc] init]; {
        [pickerView setFrame:CGRectMake(0, self.height-btnH-pickerViewH, self.width, pickerViewH)];
        [pickerView setBackgroundColor:YTRandomColor];
        [pickerView setDelegate:self];
        [pickerView setDataSource:self];
    }
    [self addSubview:pickerView];
    self.pickerView = pickerView;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [cancelBtn setFrame:CGRectMake(0, pickerView.bottomY, self.width*0.5, btnH)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:YTRandomColor];
        [cancelBtn addTarget:self action:@selector(pickerDidSelectedFinish:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [confirmBtn setFrame:CGRectMake(cancelBtn.rightX, cancelBtn.y, cancelBtn.width, btnH)];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setBackgroundColor:YTRandomColor];
        [confirmBtn addTarget:self action:@selector(pickerDidSelectedFinish:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
   
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [self.pickerView selectRow:({
        [dateFormat setDateFormat:@"M"];
        [[dateFormat stringFromDate:[NSDate date]] intValue]-1;
    }) inComponent:0 animated:YES];
    [self.pickerView selectRow:({
        [dateFormat setDateFormat:@"d"];
        [[dateFormat stringFromDate:[NSDate date]] intValue]-1;
    }) inComponent:1 animated:YES];
    [self.pickerView reloadAllComponents];
    
    [UIView animateWithDuration:0.8f animations:^{
        [self setY:0];
    }];
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.months.count;
    } else {
        NSArray *days = self.months[[pickerView selectedRowInComponent:component-1]][@"days"];
        return days.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        NSDictionary *month = self.months[row];
        return [month[@"moth"] stringByAppendingString:@" 月"];
    } else {
        NSArray *days = self.months[[pickerView selectedRowInComponent:component-1]][@"days"];
        return days[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {

        [pickerView reloadComponent:1];
        NSArray *days = self.months[[pickerView selectedRowInComponent:component]][@"days"];
        NSInteger selectRow = days.count * 0.5 + 0.5;
        [pickerView selectRow:selectRow inComponent:1 animated:YES];
    } 
}

- (void)pickerDidSelectedFinish:(UIButton *)btn {
    
    [UIView animateWithDuration:0.4f animations:^{
        [self setY:self.height+10];
    } completion:^(BOOL finished) {
        
        if (self.cancelBtn == btn) return;
        NSDictionary *month = self.months[[self.pickerView selectedRowInComponent:0]];
        NSString *day = month[@"days"][[self.pickerView selectedRowInComponent:1]];
        if ([self.delegate respondsToSelector:@selector(historyPickerView:didSelectedDate:)]) {
            [self.delegate historyPickerView:self didSelectedDate:[month[@"moth"] stringByAppendingFormat:@"/%@", day]];
        }
        [self removeFromSuperview];
    }];
}

@end