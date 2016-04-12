//
//  YTConstant.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/14.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTConstant.h"

#pragma mark - 百度
//http://apistore.baidu.com/astore/classificationservicelist.html

NSString * const APIKEY = @"a641ce54b0f6df96b923bf38e41bafb5";

NSString * const COOKLIST = @"http://apis.baidu.com/tngou/cook/list";

//车次详情接口
NSString * const APITrainNumberQ = @"http://apis.baidu.com/qunar/qunar_train_service/traindetail";
//车站搜索接口
NSString * const APITrainStationAllTrainQ = @"http://apis.baidu.com/qunar/qunar_train_service/stationsearch";
//站站搜索接口
NSString * const APITrainStationToStationQ = @"http://apis.baidu.com/qunar/qunar_train_service/s2ssearch";

#pragma mark - 易源
//https://www.showapi.com/api/apiList

NSString * const APPID = @"17180";
NSString * const APPSECRET = @"1f26c953fd0448048b9931f8ce6075dc";

#pragma mark 火车信息
//火车票价格信息查询
NSString * const APITrainPriceQ = @"http://route.showapi.com/832-3";
//列车时刻表查询
NSString * const APITrainTimeQDEPRECATED = @"http://route.showapi.com/832-2";
//火车余票信息查询
NSString * const APITrainRemainTicketQ = @"http://route.showapi.com/832-1";

