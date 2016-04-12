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
    [self.view setBackgroundColor:YTRandomColor];
    
    self.title = @"历时的今天";
    
    [self setupUIConfig];
}

- (void)setupUIConfig {
    
    CGFloat margin = 10;
    UIImageView *imageView = [[UIImageView alloc] init]; {
        [imageView setFrame:CGRectMake(margin, 64+10, YTSCREEN_W-2*margin, 200)];
        [imageView setBackgroundColor:YTRandomColor];
    }
    [self.view addSubview:imageView];
    
    UIButton *dateSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [dateSelectedBtn setFrame:CGRectMake(margin, imageView.bottomY + margin, YTSCREEN_W-2*margin, 40)];
        [dateSelectedBtn setBackgroundColor:YTRandomColor];
        [dateSelectedBtn setTitle:@"日期(月/日)" forState:UIControlStateNormal];
        [dateSelectedBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [dateSelectedBtn addTarget:self action:@selector(dateSelectedBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *dateLabel = [[UILabel alloc] init]; {
            CGFloat margin = 90;
            [dateLabel setBackgroundColor:YTRandomColor];
            [dateLabel setTextAlignment:NSTextAlignmentCenter];
            [dateLabel setText:({
                NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
                [dateFormate setDateFormat:@"M/d"];
                [dateFormate stringFromDate:[NSDate date]];
            })];
            [dateLabel setFrame:CGRectMake(margin, 0, dateSelectedBtn.width-2*margin, dateSelectedBtn.height)];
        }
        self.dateLabel = dateLabel;
        [dateSelectedBtn addSubview:dateLabel];
    }
    [self.view addSubview:dateSelectedBtn];
    
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [queryBtn setFrame:CGRectMake(margin, dateSelectedBtn.bottomY + margin, YTSCREEN_W-2*margin, 40)];
        [queryBtn setBackgroundColor:YTRandomColor];
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
