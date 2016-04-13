//
//  YTHistoryQueryController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/5.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTHistoryQueryController.h"
#import "YTHistoryPickerView.h"
#import "YTHistoryEventListController.h"

@interface YTHistoryQueryController () <YTHistoryPickerViewDelegate>

@property (nonatomic, weak) UILabel *dateLabel;

@end

@implementation YTHistoryQueryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"历时今天"];
    
    [self setupUIConfig];
}

- (void)setupUIConfig {
    
    [self.view setBackgroundColor:YTColorBackground];
    
    CGFloat margin = 10;
    UIImageView *imageView = [[UIImageView alloc] init]; {
        [imageView setFrame:CGRectMake(0, HNav+margin, YTSCREEN_W, 190)];
        [imageView setImage:[UIImage imageNamed:@"historyOfToday"]];
        [imageView setContentMode:UIViewContentModeScaleToFill];
    }
    [self.view addSubview:imageView];
    
    UIButton *dateSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [dateSelectedBtn setFrame:CGRectMake(-1, imageView.bottomY + margin, YTSCREEN_W+2, 40)];
        [dateSelectedBtn setTitle:@"日期(月/日)" forState:UIControlStateNormal];
        [dateSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [dateSelectedBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [dateSelectedBtn setContentEdgeInsets:UIEdgeInsetsMake(0, margin, 0, 0)];
        [dateSelectedBtn addTarget:self action:@selector(dateSelectedBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [dateSelectedBtn.layer setBorderWidth:HLineSeparate];
        [dateSelectedBtn.layer setBorderColor:YTColorLineSeparate];
        
        UILabel *dateLabel = [[UILabel alloc] init]; {
            CGFloat dateLabelmargin = 90;
            [dateLabel setTextAlignment:NSTextAlignmentCenter];
            [dateLabel setText:({
                NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
                [dateFormate setDateFormat:@"M/d"];
                [dateFormate stringFromDate:[NSDate date]];
            })];
            [dateLabel setFrame:CGRectMake(dateLabelmargin, 0, dateSelectedBtn.width-2*dateLabelmargin, dateSelectedBtn.height)];
        }
        self.dateLabel = dateLabel;
        [dateSelectedBtn addSubview:dateLabel];
    }
    [self.view addSubview:dateSelectedBtn];
    
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [queryBtn setFrame:CGRectMake(margin, dateSelectedBtn.bottomY + HMargin, YTSCREEN_W-2*margin, 40)];
        [queryBtn setBackgroundColor:YTColorQueryButton];
        [queryBtn.layer setMasksToBounds:YES];
        [queryBtn.layer setCornerRadius:5];
        [queryBtn setTitle:@"查看" forState:UIControlStateNormal];
        [queryBtn addTarget:self action:@selector(queryBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:queryBtn];
}

- (void)dateSelectedBtnDidClick:(UIButton *)btn {
    
    YTHistoryPickerView *pickerView = [[YTHistoryPickerView alloc] init]; {
        [pickerView setDelegate:self];
        [pickerView showPicker];
    }
}

- (void)queryBtnDidClick:(UIButton *)btn {
    
    if (self.dateLabel.text.length) {
        YTHistoryEventListController *eventListVC = [[YTHistoryEventListController alloc] init];
        eventListVC.historyDate = self.dateLabel.text;
        [self.navigationController pushViewController:eventListVC animated:YES];
    }
}

- (void)historyPickerView:(YTHistoryPickerView *)pickView didSelectedDate:(NSString *)dateString {

    [self.dateLabel setText:dateString];
}

@end
