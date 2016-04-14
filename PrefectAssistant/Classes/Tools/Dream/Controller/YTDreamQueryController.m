//
//  YTDreamQueryController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTDreamQueryController.h"
#import "YTDreamListController.h"

@interface YTDreamQueryController ()

@property (nonatomic, weak) UITextField *keyWordField;

@end

@implementation YTDreamQueryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:YTColorBackground];
    
    [self setTitle:@"解梦"];
    
    UITextField *keyWordField = [[UITextField alloc] init]; {
        [keyWordField setFrame:CGRectMake(-1, HNav+HMargin, YTSCREEN_W+2, 40)];
        [keyWordField setPlaceholder:@"梦境关键词"];
        [keyWordField setLeftViewMode:UITextFieldViewModeAlways];
        [keyWordField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)]];
        [keyWordField setBackgroundColor:[UIColor whiteColor]];
        [keyWordField.layer setBorderWidth:HLineSeparate];
        [keyWordField.layer setBorderColor:YTColorLineSeparate];
    }
    [self.view addSubview:keyWordField];
    self.keyWordField = keyWordField;
    
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [queryBtn setFrame:CGRectMake(10, keyWordField.bottomY+HMargin, YTSCREEN_W-2*10, 40)];
        [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
        [queryBtn addTarget:self action:@selector(queryBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [queryBtn setBackgroundColor:YTColorQueryButton];
        [queryBtn.layer setMasksToBounds:YES];
        [queryBtn.layer setCornerRadius:5];
    }
    [self.view addSubview:queryBtn];
}

- (void)queryBtnDidClick {
    
    if (!self.keyWordField.text.length) {
        [YTAlertView showAlertMsg:@"请输入梦中的关键词"];
        return;
    }
    
    YTDreamListController *dreamListVC = [[YTDreamListController alloc] init];
    dreamListVC.keyWord = self.keyWordField.text;
    [self.navigationController pushViewController:dreamListVC animated:YES];
}

@end
