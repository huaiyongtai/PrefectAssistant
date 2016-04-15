//
//  YTExpressageController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/30.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTExpressageController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface YTExpressageController () <UIWebViewDelegate>

@end

@implementation YTExpressageController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setTitle:@"快递速查"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds]; {
        [webView loadRequest:({
            
            [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.kuaidi100.com/index_all.html?"]];
        })];
        [webView setDelegate:self];
    }
    [self.view addSubview:webView];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
   
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
   
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}




@end
