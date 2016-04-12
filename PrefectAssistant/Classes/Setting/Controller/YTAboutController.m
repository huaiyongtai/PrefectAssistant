//
//  YTAboutController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/12.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTAboutController.h"

@implementation YTAboutController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"关于";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [dismissBtn setFrame:CGRectMake(0, 30, 45, 40)];
        [dismissBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
        [dismissBtn addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
        [dismissBtn setBackgroundColor:YTRandomColor];
    }
    [self.view addSubview:dismissBtn];
    
    UILabel *tiplLabel = [[UILabel alloc] init]; {
        [tiplLabel setFrame:CGRectMake(0, dismissBtn.bottomY, YTSCREEN_W, 200)];
        
        [tiplLabel setTextAlignment:NSTextAlignmentCenter];
        [tiplLabel setNumberOfLines:0];
        [tiplLabel setText:@"百分助理"];
        
    }
    [self.view addSubview:tiplLabel];
}

- (void)dismissVC {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
