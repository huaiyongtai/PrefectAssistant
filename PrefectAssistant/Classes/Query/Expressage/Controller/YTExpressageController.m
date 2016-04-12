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
    
//    http://m.kuaidi100.com/index_all.html?
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:({
    
        [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.kuaidi100.com/index_all.html?"]];
    
    
    })];
    [self.view addSubview:webView];
//    
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    [mgr.requestSerializer setValue:APIKEY forHTTPHeaderField:@"apikey"];
//    [mgr GET:@"http://m.kuaidi100.com/index_all.html?" parameters:nil  progress:^(NSProgress * _Nonnull downloadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error:%@", error);
//    }];

}


@end
