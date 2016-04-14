//
//  YTHTTPTool.h
//  无法修盖
//
//  Created by HelloWorld on 16/1/27.
//  Copyright © 2016年 SearchPrefect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTHTTPTool : NSObject

+ (void)bdGet:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)bdGet:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/** 发送GET请求 */
+ (void)get:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)get:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/** 发送POST请求 */
+ (void)post:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url parameters:(id)parameters autoShowLoading:(BOOL)showLoading success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
