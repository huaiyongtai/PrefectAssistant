//
//  YTTrainInfoQueryController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/24.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainInfoQueryController.h"
#import "YTNavTitleBtn.h"
#import "YTDropDownMenu.h"
#import "YTMenuContentView.h"
#import "YTTarinQueryView.h"
#import "CalendarHomeViewController.h"
#import "YTStationToStationController.h"
#import "YTTrainNumberController.h"
#import "YTTrainStationController.h"
#import "YTTrainInfoQuery.h"


@interface YTTrainInfoQueryController () <YTDropDownMenuDelegate, YTTarinQueryViewDelegate>

@property (nonatomic, weak) YTTarinQueryView *queryView;

@end

@implementation YTTrainInfoQueryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitleView:({
        YTNavTitleBtn *customBtn = [YTNavTitleBtn buttonWithType:UIButtonTypeCustom]; {
            [customBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
            [customBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
            [customBtn setTitle:@"车票查询" forState:UIControlStateNormal];
            [customBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [customBtn setFrame:CGRectMake(0, 0, 50, 35)];
            [customBtn addTarget:self action:@selector(dropMenuForSelectedQuery:) forControlEvents:UIControlEventTouchUpInside];
        }
        customBtn;
    })];
    
    //模拟一次查询选中
    [self.queryView setQuery:[YTTrainInfoQuery trainInfoQueryWithQueryType:YTTrainInfoQueryTypeStationToStaion]];
    
    NSDate *tomorrowDate = ({
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        [components setDay:([components day]+1)];
        [gregorian dateFromComponents:components];
    });
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init]; {
        [dateday setDateFormat:@"YYYY-MM-dd"];
        [dateday stringFromDate:tomorrowDate];
    }
    NSInteger weekIntValue = [tomorrowDate getWeekIntValueWithDate];
    [self.queryView setQueryCalender:[dateday stringFromDate:tomorrowDate]
                                week:[NSDate getWeekStringFromInteger:weekIntValue]];
}

- (void)dropMenuForSelectedQuery:(YTNavTitleBtn *)navTitleBtn {
    
    YTDropDownMenu *menu = [[YTDropDownMenu alloc] init]; {
        [menu setContentView:({
            YTMenuContentView *queryView = [[YTMenuContentView alloc] init];
            [queryView setQueryItems:@[
                 [YTTrainInfoQuery trainInfoQueryWithQueryType:YTTrainInfoQueryTypeStationToStaion],
                 [YTTrainInfoQuery trainInfoQueryWithQueryType:YTTrainInfoQueryTypeStationName],
                 [YTTrainInfoQuery trainInfoQueryWithQueryType:YTTrainInfoQueryTypeTrainNo]
            ]];
            
            __weak YTDropDownMenu *weakMenu = menu;
            [queryView setItemBlock:^(YTTrainInfoQuery *query) {
                
                self.queryView.query = query;
                [navTitleBtn setTitle:query.queryName forState:UIControlStateNormal];
                [weakMenu dismiss];
            }];
            [queryView setFrame:CGRectMake(0, 0, 150, 100)];
            queryView;
        })];
        [menu setDelegate:self];
        [menu showFromView:navTitleBtn];
    }
}

- (YTTarinQueryView *)queryView  {

    if (_queryView == nil) {
        YTTarinQueryView *queryView = [[YTTarinQueryView alloc] initWithFrame:CGRectMake(0, 100, YTSCREEN_W, 400)];
        [queryView setDelegate:self];
        [self.view addSubview:queryView];
        _queryView = queryView;
    }
    return _queryView;
}
#pragma mark - YTDropDownMenuDelegate
- (void)dropDownMenuDidShowMenu:(YTDropDownMenu *)menu {
    [(UIButton *)self.navigationItem.titleView setSelected:YES];
}

- (void)dropDownMenuDidDismissMenu:(YTDropDownMenu *)menu {
    [(UIButton *)self.navigationItem.titleView setSelected:NO];
}

#pragma mark - YTTarinQueryViewDelegate
- (void)trarinQueryViewDidSelectedDepartedTime:(YTTarinQueryView *)queryView {
    
    CalendarHomeViewController *chvc = [[CalendarHomeViewController alloc]init]; {
        [chvc setCalendartitle:@"乘车日期"];
        [chvc setTrainToDay:60 ToDateforString:nil];
        [chvc setCalendarblock:^(CalendarDayModel *calendar){
            [queryView setQueryCalender:[calendar toString] week:[calendar getWeek]];
        }];
    }
    [self.navigationController pushViewController:chvc animated:YES];
}
- (void)trarinQueryView:(YTTarinQueryView *)queryView didSelectedQuery:(YTTrainInfoQuery *)query {

    switch (query.queryType) {
        case YTTrainInfoQueryTypeTrainNo: {
            YTTrainNumberController *trainNoVC = [[YTTrainNumberController alloc] init];
            trainNoVC.trainQuery = query;
            [self.navigationController pushViewController:trainNoVC animated:YES];
            break;
        }
        case YTTrainInfoQueryTypeStationName: {
            YTTrainStationController *trainStationoVC = [[YTTrainStationController alloc] init];
            trainStationoVC.trainQuery = query;
            [self.navigationController pushViewController:trainStationoVC animated:YES];
            break;
        }
        case YTTrainInfoQueryTypeStationToStaion: {
            YTStationToStationController *vc = [[YTStationToStationController alloc] init];
            vc.trainQuery = query;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
    }
    
}

@end
