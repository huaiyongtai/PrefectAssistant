//
//  YTConstant.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/14.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTConstant.h"

#pragma mark - 常量
const float HLineSeparate = 0.5f;
const float HNav          = 64.0f;
const float HMargin       = 36.0f;

NSString * const YTHTTPDataZero      = @"没有更多数据....";
NSString * const YTHTTPDataException = @"数据异常，请重新请求数据";
NSString * const YTHTTPFailure       = @"请求错误，返回上一级重新请求数据";

#pragma mark - 百度

NSString * const APIBaiduKey               = @"a641ce54b0f6df96b923bf38e41bafb5";

//车次详情接口
NSString * const APITrainNumberQ           = @"http://apis.baidu.com/qunar/qunar_train_service/traindetail";
//车站搜索接口
NSString * const APITrainStationAllTrainQ  = @"http://apis.baidu.com/qunar/qunar_train_service/stationsearch";
//站站搜索接口
NSString * const APITrainStationToStationQ = @"http://apis.baidu.com/qunar/qunar_train_service/s2ssearch";

//菜谱-分类
NSString * const APICookClassifyQ          = @"http://apis.baidu.com/tngou/cook/classify";
//菜品-列表
NSString * const APICookListQ              = @"http://apis.baidu.com/tngou/cook/list";
//菜谱-名称
NSString * const APICookNameQ              = @"http://apis.baidu.com/tngou/cook/name";
//菜谱-详细
NSString * const APICookShowQ              = @"http://apis.baidu.com/tngou/cook/show";

//翻译
NSString * const APITranslateQ             = @"http://apis.baidu.com/apistore/tranlateservice/translate";

//驾考测试
NSString * const APIDriverExamQ            = @"http://apis.baidu.com/bbtapi/jztk/jztk_query";

#pragma mark - 聚合
//TV-key
NSString * const APITVKey                  = @"059cb6397da1481fa2221fe60a3c9dfa";
//TV-频道列表
NSString * const APITVChannelQ             = @"http://japi.juhe.cn/tv/getChannel";
//TV-节目时间表
NSString * const APITVProgramQ             = @"http://japi.juhe.cn/tv/getProgram";

//Joke-key
NSString * const APIJokeKey                = @"3c08a985114fc4c68aed3ca693cc9da1";
//Joke-文字
NSString * const APIJokeTextQ              = @"http://japi.juhe.cn/joke/content/text.from" ;
//Joke-图片
NSString * const APIJokeImgQ               = @"http://japi.juhe.cn/joke/img/text.from";

//History-key
NSString * const APIHistoryKey             = @"c5770adc04027151413c7b1437cccc8a";
//History-历史事件列表
NSString * const APIHistoryQueryEventQ     = @"http://v.juhe.cn/todayOnhistory/queryEvent.php";
//History-历史事件详情
NSString * const APIHistoryQueryDetailQ    = @"http://v.juhe.cn/todayOnhistory/queryDetail.php";

//Dream-key
NSString * const APIDreamKey               = @"50d88e8ad11b50b0ab49d119b61e13b0";
//Dream-查询
NSString * const APIDreamQ                 = @"http://v.juhe.cn/dream/query";

//PostCode-key
NSString * const APIPostCodeKey            = @"d6ba9692abd2fe847ef40312077fa940";
//PostCode-搜索
NSString * const APIPostCodeSearchQ        = @"http://v.juhe.cn/postcode/search";

//Bus-key
NSString * const APIBusKey                 = @"455307040fbad32f14f83169a450db38";
//Bus-BusLine
NSString * const APIBusLineQ               = @"http://op.juhe.cn/189/bus/busline";
//Bus-BusStation
NSString * const APIBusStationQ            = @"http://op.juhe.cn/189/bus/station";

