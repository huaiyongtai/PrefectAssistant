//
//  YTBusQueryController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTBusQueryController.h"
#import "YTBusStationController.h"

@interface YTBusQueryController ()

@property (nonatomic, weak) UIButton *selectedQueryBtn;

@property (nonatomic, weak) UITextField *addressField;
@property (nonatomic, weak) UITextField *busKeywordField;


@end

@implementation YTBusQueryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"公交信息查询";
    [self.view setBackgroundColor:YTRandomColor];
   
    CGFloat margin = 20;
    UITextField *addressField = [[UITextField alloc] init]; {
        [addressField setFrame:CGRectMake(-1, 64+margin, YTSCREEN_W+2, 40)];
        [addressField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)]];
        [addressField setLeftViewMode:UITextFieldViewModeAlways];
        [addressField setPlaceholder:@"城市名称 如：长春"];
        [addressField setBackgroundColor:YTRandomColor];
    }
    [self.view addSubview:addressField];
    self.addressField = addressField;

    UITextField *busKeywordField = [[UITextField alloc] init]; {
        [busKeywordField setFrame:CGRectMake(-1, addressField.bottomY+margin, YTSCREEN_W+2, 40)];
        [busKeywordField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)]];
        [busKeywordField setLeftViewMode:UITextFieldViewModeAlways];
        [busKeywordField setBackgroundColor:YTRandomColor];
    }
    [self.view addSubview:busKeywordField];
    self.busKeywordField = busKeywordField;
    
    CGFloat radioBtnW = 100;
    CGFloat radioBtnH = 40;
    CGFloat radioBtnMargin = (YTSCREEN_W-2*radioBtnW) / 3;
    UIButton *stationNameBtn = [self setupRadioBtnWithTitle:@"站台名称" action:@selector(radioBtnDidClick:)]; {
        [stationNameBtn setTag:1];
        [stationNameBtn setFrame:CGRectMake(radioBtnMargin, busKeywordField.bottomY, radioBtnW, radioBtnH)];
    }
    [self.view addSubview:stationNameBtn];
    [self radioBtnDidClick:stationNameBtn];
    
    UIButton *busLineBtn = [self setupRadioBtnWithTitle:@"公交线路" action:@selector(radioBtnDidClick:)]; {
        [busLineBtn setTag:2];
        [busLineBtn setFrame:CGRectMake(stationNameBtn.rightX+radioBtnMargin, busKeywordField.bottomY, radioBtnW, radioBtnH)];
    }
    [self.view addSubview:busLineBtn];
    
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        
        [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
        [queryBtn addTarget:self action:@selector(queryDidClick) forControlEvents:UIControlEventTouchUpInside];
        [queryBtn setFrame:CGRectMake(margin, busLineBtn.bottomY+margin, YTSCREEN_W-2*margin, 40)];
        [queryBtn setBackgroundColor:YTRandomColor];
    }
    [self.view addSubview:queryBtn];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.addressField becomeFirstResponder];
}

- (UIButton *)setupRadioBtnWithTitle:(NSString *)title action:(SEL)action {
    
    UIButton *radioBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [radioBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        [radioBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [radioBtn setTitle:title forState:UIControlStateNormal];
        [radioBtn setImage:[UIImage imageNamed:@"btn_more_choice_nor"] forState:UIControlStateNormal];
        [radioBtn setImage:[UIImage imageNamed:@"btn_more_choice_pre"] forState:UIControlStateSelected];
        [radioBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        [radioBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [radioBtn setBackgroundColor:YTRandomColor];
    }
    return radioBtn;
}
- (void)radioBtnDidClick:(UIButton *)btn {
    
    [self.view endEditing:YES];
    
    if (self.selectedQueryBtn != btn) {
        self.busKeywordField.text = nil;
    }
    
    [self.selectedQueryBtn setSelected:NO];
    [btn setSelected:YES];
    self.selectedQueryBtn = btn;
    
    if (btn.tag == 1) {
        [self.busKeywordField setPlaceholder:@"公交站台名称 如：延安大街"];
        [self.busKeywordField setKeyboardType:UIKeyboardTypeDefault];
    } else {
        [self.busKeywordField setPlaceholder:@"公交线路 如：13路->13"];
        [self.busKeywordField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    [self.busKeywordField becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
- (void)queryDidClick {
   
    [self.view endEditing:YES];
    
    
    if (!(self.busKeywordField.text.length && self.addressField.text.length)) {
        [YTAlertView showAlertMsg:@"信息填写不完整"];
        return;
    }
    
    YTBusStationController *busStationVC = [[YTBusStationController alloc] init]; {
        busStationVC.busInfo = self.busKeywordField.text;
        busStationVC.address = self.addressField.text;
        if (self.selectedQueryBtn.tag == 1) {
            busStationVC.infoType = YTBusInfoTypeBusStation;
        } else {
            busStationVC.infoType = YTBusInfoTypeBusLine;
        }
    }
    
    [self.navigationController pushViewController:busStationVC animated:YES];
    NSLog(@"开始查询");
}
@end
