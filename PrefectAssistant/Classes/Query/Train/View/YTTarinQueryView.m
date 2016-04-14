//
//  YTTarinQueryView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/25.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTarinQueryView.h"
#import "YTTrainInfoQuery.h"

@interface YTTarinQueryView ()

@property (nonatomic, weak) UITextField *startStationFiled;
@property (nonatomic, weak) UITextField *endStationFiled;

@property (nonatomic, weak) UILabel *departMothLabel;
@property (nonatomic, weak) UILabel *departWeekLabel;
@property (nonatomic, copy) NSString *departCalenderString;

@property (nonatomic, weak) UITextField *stationNameField;
@property (nonatomic, weak) UITextField *stationNumField;


//车次
@property (nonatomic, strong) UIView *queryStationInfoView;

//车次
@property (nonatomic, strong) UIView *queryStationNumView;

//站到站
@property (nonatomic, strong) UIView *queryAddressView;

//时间选择
@property (nonatomic, strong) UIView *departTimeView;

//查询按钮
@property (nonatomic, strong) UIButton *queryBtn;

//当前显示的View
@property (nonatomic, strong) UIView *currentShowView;

@end

@implementation YTTarinQueryView

#pragma mark - 懒加载视图
- (UIView *)queryAddressView {
    if (_queryAddressView == nil) {
        UIView *queryAddressView = [[UIView alloc] init]; {
            [queryAddressView setFrame:CGRectMake(0, 0, YTSCREEN_W, 40)];
            
            CGFloat width = queryAddressView.width/3;
            CGFloat height = queryAddressView.height;
            UITextField *startStationFiled = [[UITextField alloc] init]; {
                [startStationFiled setFrame:CGRectMake(0, 0, width, height)];
                [startStationFiled setPlaceholder:@"出发站，如：北京"];
                [startStationFiled setTextAlignment:NSTextAlignmentCenter];
            }
            self.startStationFiled = startStationFiled;
            [queryAddressView addSubview:startStationFiled];
            
            UIButton *exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
                [exchangeBtn setFrame:CGRectMake(startStationFiled.rightX, 0, width, height)];
                [exchangeBtn addTarget:self action:@selector(exchangeBetweentStartAndEnd) forControlEvents:UIControlEventTouchUpInside];
                [exchangeBtn setImage:[UIImage imageNamed:@"exchange"] forState:UIControlStateNormal];
                [exchangeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [exchangeBtn setTitleColor:YTColorGrayText forState:UIControlStateNormal];
            }
            [queryAddressView addSubview:exchangeBtn];
            
            UITextField *endStationFiled = [[UITextField alloc] init]; {
                [endStationFiled setFrame:CGRectMake(exchangeBtn.rightX, 0, width, height)];
                [endStationFiled setPlaceholder:@"目的站：如：长春"];
                [endStationFiled setTextAlignment:NSTextAlignmentCenter];
            }
            self.endStationFiled = endStationFiled;
            [queryAddressView addSubview:endStationFiled];
            
            CALayer *lineLayer = [CALayer layer]; {
                [lineLayer setFrame:CGRectMake(0, height-HLineSeparate, YTSCREEN_W, HLineSeparate)];
                [lineLayer setBackgroundColor:YTColorLineSeparate];
            }
            [queryAddressView.layer addSublayer:lineLayer];
        }
        _queryAddressView = queryAddressView;
    }
    
    return _queryAddressView;
}
- (UIView *)queryStationNumView {
    if (_queryStationNumView == nil) {
        UIView *queryStationNumView = [[UIView alloc] init]; {
            [queryStationNumView setFrame:CGRectMake(0, 0, YTSCREEN_W, 40)];
            
            CGFloat width = queryStationNumView.width/2;
            CGFloat height = queryStationNumView.height;
            UILabel *stationTipLabel = [[UILabel alloc] init]; {
                [stationTipLabel setText:@"车次："];
                [stationTipLabel setFrame:CGRectMake(10, 0, width, height)];
            }
            [queryStationNumView addSubview:stationTipLabel];
            
            UITextField *stationNumField = [[UITextField alloc] init]; {
                [stationNumField setFrame:CGRectMake(0, 0, queryStationNumView.width, height)];
                [stationNumField setTextAlignment:NSTextAlignmentCenter];
                [stationNumField setPlaceholder:@"列车名，如：G43"];
            }
            self.stationNumField = stationNumField;
            [queryStationNumView addSubview:stationNumField];
            
            CALayer *lineLayer = [CALayer layer]; {
                [lineLayer setFrame:CGRectMake(0, height-HLineSeparate, YTSCREEN_W, HLineSeparate)];
                [lineLayer setBackgroundColor:YTColorLineSeparate];
            }
            [queryStationNumView.layer addSublayer:lineLayer];
        }
        _queryStationNumView = queryStationNumView;
    }
    return _queryStationNumView;
    
}
- (UIView *)queryStationInfoView {
    if (_queryStationInfoView == nil) {
        UIView *queryStationInfoView = [[UIView alloc] init]; {
            [queryStationInfoView setFrame:CGRectMake(0, 0, YTSCREEN_W, 40)];
            
            CGFloat width = queryStationInfoView.width/2;
            CGFloat height = queryStationInfoView.height;
            UILabel *stationTipLabel = [[UILabel alloc] init]; {
                [stationTipLabel setText:@"车站名："];
                [stationTipLabel setFrame:CGRectMake(10, 0, width, height)];
            }
            [queryStationInfoView addSubview:stationTipLabel];
            
            UITextField *stationNameField = [[UITextField alloc] init]; {
                [stationNameField setFrame:CGRectMake(0, 0, queryStationInfoView.width, height)];
                [stationNameField setPlaceholder:@"火车站，如：西安"];
                [stationNameField setTextAlignment:NSTextAlignmentCenter];
            }
            self.stationNameField = stationNameField;
            [queryStationInfoView addSubview:stationNameField];
            
            CALayer *lineLayer = [CALayer layer]; {
                [lineLayer setFrame:CGRectMake(0, height-HLineSeparate, YTSCREEN_W, HLineSeparate)];
                [lineLayer setBackgroundColor:YTColorLineSeparate];
            }
            [queryStationInfoView.layer addSublayer:lineLayer];
        }
        _queryStationInfoView = queryStationInfoView;
    }
    return _queryStationInfoView;
    
}
- (UIView *)departTimeView {
    
    if (_departTimeView == nil) {
        UIButton *departTimeView = [UIButton buttonWithType:UIButtonTypeCustom]; {
            [departTimeView setFrame:CGRectMake(0, 0, YTSCREEN_W, 40)];
            [departTimeView setTitle:@"出发时间" forState:UIControlStateNormal];
            [departTimeView setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [departTimeView setTitleColor:YTColor(100, 100, 100) forState:UIControlStateNormal];
            [departTimeView setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [departTimeView addTarget:self action:@selector(departTimeDidSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            CGFloat width = departTimeView.width / 3;
            CGFloat height = departTimeView.height;
            UILabel *departMothLabel = [[UILabel alloc] init]; {
                [departMothLabel setFrame:CGRectMake(width, 0, width, height)];
                [departMothLabel setTextAlignment:NSTextAlignmentCenter];
                [departMothLabel setTextColor:YTColorGrayText];
            }
            self.departMothLabel = departMothLabel;
            [departTimeView addSubview:departMothLabel];
            
            UILabel *departWeekLabel = [[UILabel alloc] init]; {
                [departWeekLabel setFrame:CGRectMake(departMothLabel.rightX, 0, width, height)];
                [departWeekLabel setTextAlignment:NSTextAlignmentCenter];
                [departWeekLabel setTextColor:YTColorGrayText];
            }
            self.departWeekLabel = departWeekLabel;
            [departTimeView addSubview:departWeekLabel];
            
            CALayer *lineLayer = [CALayer layer]; {
                [lineLayer setFrame:CGRectMake(0, height-HLineSeparate, YTSCREEN_W, HLineSeparate)];
                [lineLayer setBackgroundColor:YTColorLineSeparate];
            }
            [departTimeView.layer addSublayer:lineLayer];
        }
        _departTimeView = departTimeView;

    }
    return _departTimeView;
}
- (UIButton *)queryBtn {
    
    if (_queryBtn == nil) {
        UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
            CGFloat margin = 10;
            [queryBtn addTarget:self action:@selector(trainInfoQueryDidClick) forControlEvents:UIControlEventTouchUpInside];
            [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
            [queryBtn setTitleColor:YTColor(50, 50, 50) forState:UIControlStateNormal];
            [queryBtn setFrame:CGRectMake(margin, 0, YTSCREEN_W-2*margin, 40)];
            [queryBtn setBackgroundColor:YTColorQueryButton];
            [queryBtn.layer setMasksToBounds:YES];
            [queryBtn.layer setCornerRadius:5];
        }
        _queryBtn = queryBtn;
    }
    return _queryBtn;
}
- (UIView *)currentShowView {
    if (_currentShowView == nil) {
        UIView * currentShowView = [[UIView alloc] init];
        [self addSubview:currentShowView];
        _currentShowView = currentShowView;
    }
    return _currentShowView;
}

//组装新的视图
- (UIView *)setupNewQueryViewWith:(YTTrainInfoQuery *)query {
    
    [[self.currentShowView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.currentShowView.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            self.currentShowView.alpha = 1.0f;
        }];
    }];
    
    CGFloat margin = 10;
    switch (query.queryType) {
        case YTTrainInfoQueryTypeTrainNo: {
            
            [self.currentShowView addSubview:self.queryStationNumView];
            [self.currentShowView addSubview:self.departTimeView];
            [self.currentShowView addSubview:self.queryBtn];
            
            self.departTimeView.y = self.queryStationNumView.bottomY + margin;
            self.queryBtn.y = self.departTimeView.bottomY + HMargin;
           
            self.stationNumField.text = self.query.trainNo;
            break;
        }
        case YTTrainInfoQueryTypeStationName: {
            
            [self.currentShowView addSubview:self.queryStationInfoView];
            [self.currentShowView addSubview:self.queryBtn];
            
            self.queryBtn.y = self.queryStationInfoView.bottomY + HMargin;
            
            self.stationNameField.text = self.query.stationName;
            break;
        }
        case YTTrainInfoQueryTypeStationToStaion: {
            [self.currentShowView addSubview:self.queryAddressView];
            [self.currentShowView addSubview:self.departTimeView];
            [self.currentShowView addSubview:self.queryBtn];
            
            self.departTimeView.y = self.queryAddressView.bottomY + margin;
            self.queryBtn.y = self.departTimeView.bottomY + HMargin;
            
            self.startStationFiled.text = self.query.startStation;
            self.endStationFiled.text = self.query.endStation;
            break;
        }
    }
    
    [self.currentShowView setFrame:CGRectMake(0, 0, YTSCREEN_W, self.queryBtn.bottomY)];

    return nil;
}

- (void)setQuery:(YTTrainInfoQuery *)query {
    
    _query = query;
    [self setupNewQueryViewWith:query];
}
- (void)setQueryCalender:(NSString *)calenderStr week:(NSString *)weekStr {

    self.departCalenderString = calenderStr;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:calenderStr];
    [dateFormatter setDateFormat:@"MM-dd"];
    self.departMothLabel.text = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat:@"YYYY"];
    self.departWeekLabel.text = [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:date], weekStr];
    
}

- (void)exchangeBetweentStartAndEnd {
    
    NSString *tempStr = self.startStationFiled.text;
    self.startStationFiled.text = self.endStationFiled.text;
    self.endStationFiled.text = tempStr;
}

- (void)departTimeDidSelected:(UIButton *)timePicker {
    
    if ([self.delegate respondsToSelector:@selector(trarinQueryViewDidSelectedDepartedTime:)]) {
        [self.delegate trarinQueryViewDidSelectedDepartedTime:self];
    }
}

- (void)trainInfoQueryDidClick {
   
    switch (self.query.queryType) {
        case YTTrainInfoQueryTypeTrainNo: {
            self.query.trainNo = self.stationNumField.text;
            self.query.departedTime = self.departCalenderString;
            break;
            
        }
        case YTTrainInfoQueryTypeStationName: {
           self.query.stationName = self.stationNameField.text;
            break;
        }
        case YTTrainInfoQueryTypeStationToStaion: {
            self.query.startStation = self.startStationFiled.text;
            self.query.endStation = self.endStationFiled.text;
            self.query.departedTime = self.departCalenderString;
            break;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(trarinQueryView:didSelectedQuery:)]) {
        [self.delegate trarinQueryView:self didSelectedQuery:self.query];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];    
    self.height = self.currentShowView.bottomY;
}

@end
