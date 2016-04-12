//
//  YTConstant.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/14.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//  静态常量

#import <Foundation/Foundation.h>

#pragma mark - 百度
//http://apistore.baidu.com/astore/classificationservicelist.html

extern NSString * const APIKEY;

extern NSString * const COOKLIST;

//列车时刻表查询
extern NSString * const APITrainNumberQ;
//车站搜索接口
extern NSString * const APITrainStationAllTrainQ;
//站站搜索接口
extern NSString * const APITrainStationToStationQ;


#pragma mark - 易源
//https://www.showapi.com/api/apiList

extern NSString * const APPID;
extern NSString * const APPSECRET;

//火车票价格信息查询
extern NSString * const APITrainPriceQ;

//列车时刻表查询
extern NSString * const APITrainTimeQDEPRECATED;    //deprecated; 时间不准确

//火车余票信息查询
extern NSString * const APITrainRemainTicketQ;


//- (void)loadTrainTimetableInfoFromNetworkDeprecated {
//    
//    NSString *timestamp = ({
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//        [dateFormatter stringFromDate:[NSDate date]];
//    });
//    
//    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
//    [paramters setObject:APPID forKey:@"showapi_appid"];
//    [paramters setObject:APPSECRET forKey:@"showapi_sign"];
//    [paramters setObject:timestamp forKey:@"showapi_timestamp"];
//    [paramters setObject:@"T41" forKey:@"train_num"];
//    
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    [mgr GET:APITrainTimeQDEPRECATED parameters:paramters  progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"%@", responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error:%@", error);
//    }];
//}