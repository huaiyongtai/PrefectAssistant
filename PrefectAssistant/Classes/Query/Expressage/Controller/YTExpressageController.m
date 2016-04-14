//
//  YTExpressageController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/30.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTExpressageController.h"

@interface YTExpressageController ()

@end

@implementation YTExpressageController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setTitle:@"快递速查"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:({
    
        [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.kuaidi100.com/index_all.html?"]];
     })];
    [self.view addSubview:webView];
}


@end
