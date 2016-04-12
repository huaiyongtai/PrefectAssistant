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
    
    [self.view setBackgroundColor:YTRandomColor];
    
    self.title = @"解梦";
    
    UITextField *keyWordField = [[UITextField alloc] init]; {
        [keyWordField setFrame:CGRectMake(0, 100, YTSCREEN_W, 40)];
        [keyWordField setPlaceholder:@"梦境关键词"];
        [keyWordField setBackgroundColor:YTRandomColor];
        [keyWordField setLeftViewMode:UITextFieldViewModeAlways];
        [keyWordField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)]];
    }
    [self.view addSubview:keyWordField];
    self.keyWordField = keyWordField;
    
    UIButton *queryBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        
        [queryBtn setFrame:CGRectMake(50, 200, YTSCREEN_W-2*50, 40)];
        [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
        [queryBtn addTarget:self action:@selector(queryBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [queryBtn setBackgroundColor:YTRandomColor];
        
    }
    [self.view addSubview:queryBtn];
}

- (void)queryBtnDidClick {
    
    
    YTDreamListController *dreamListVC = [[YTDreamListController alloc] init];
    dreamListVC.keyWord = self.keyWordField.text;
    [self.navigationController pushViewController:dreamListVC animated:YES];
}

@end
