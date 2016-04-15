//
//  YTHTTPTool.m
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import "YTHTTPTool.h"
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"
#import "YTAlertView.h"

static AFNetworkReachabilityStatus _lastNetworkStatus = AFNetworkReachabilityStatusUnknown;

@implementation YTHTTPTool

+ (void)initialize {
    
    //1.加载网络监听器
    AFNetworkReachabilityManager *networkMgr = [AFNetworkReachabilityManager sharedManager];
    [networkMgr startMonitoring];
    [networkMgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        _lastNetworkStatus = status;
    }];
}

#pragma mark - 百度API请求
+ (void)bdGet:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self bdGet:url parameters:parameters autoShowLoading:NO success:success failure:failure];
}
+ (void)bdGet:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    if (_lastNetworkStatus == AFNetworkReachabilityStatusNotReachable) {
        [YTAlertView showAlertMsg:@"抱歉您似乎已经和网络已断开连接"];
        return;
    }
   
    UIView *topView = [[UIApplication sharedApplication].windows lastObject];
    if (showLoading) { [MBProgressHUD showHUDAddedTo:topView animated:YES]; }
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer setValue:APIBaiduKey forHTTPHeaderField:@"apikey"];
    [mgr GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showLoading) { [MBProgressHUD hideHUDForView:topView animated:YES]; }
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoading) { [MBProgressHUD hideHUDForView:topView animated:YES]; }
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - GET请求
+ (void)get:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self get:url parameters:parameters autoShowLoading:NO success:success failure:failure];
}
+ (void)get:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    if (_lastNetworkStatus == AFNetworkReachabilityStatusNotReachable) {
        [YTAlertView showAlertMsg:@"抱歉您似乎已经和网络已断开连接"];
        return;
    }
   
    UIView *topView = [[UIApplication sharedApplication].windows lastObject];
    if (showLoading) { [MBProgressHUD showHUDAddedTo:topView animated:YES]; }
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showLoading) { [MBProgressHUD hideHUDForView:topView animated:YES]; }
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoading) { [MBProgressHUD hideHUDForView:topView animated:YES]; }
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - POST请求
+ (void)post:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self post:url parameters:parameters autoShowLoading:NO success:success failure:failure];
}
+ (void)post:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    if (_lastNetworkStatus == AFNetworkReachabilityStatusNotReachable) {
        [YTAlertView showAlertMsg:@"抱歉您似乎已经和网络已断开连接"];
        return;
    }
    
    UIView *topView = [[UIApplication sharedApplication].windows lastObject];
    if (showLoading) { [MBProgressHUD showHUDAddedTo:topView animated:YES]; }
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showLoading) { [MBProgressHUD hideHUDForView:topView animated:YES]; }
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoading) { [MBProgressHUD hideHUDForView:topView animated:YES]; }
        if (failure) {
            failure(error);
        }
    }];
}

@end
