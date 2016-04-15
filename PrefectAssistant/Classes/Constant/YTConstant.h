//
//  YTConstant.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/14.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//  静态常量

#import <Foundation/Foundation.h>

#pragma mark - 常量
extern const float HLineSeparate;   //分割线
extern const float HNav;            //导航高度
extern const float HMargin;         //标准间距

//网络请求提示
extern NSString * const YTHTTPDataZero;         //数据请求成功、返回数据为空
extern NSString * const YTHTTPDataException;    //数据请求成功、返回数据异常
extern NSString * const YTHTTPFailure;          //请求失败

#pragma mark - 百度

extern NSString * const APIBaiduKey;

//列车时刻表查询
extern NSString * const APITrainNumberQ;
//车站搜索接口
extern NSString * const APITrainStationAllTrainQ;
//站站搜索接口
extern NSString * const APITrainStationToStationQ;

//菜谱-分类
extern NSString * const APICookClassifyQ;
//菜谱-名称
extern NSString * const APICookNameQ;
//菜谱-列表
extern NSString * const APICookListQ;
//菜谱-详细
extern NSString * const APICookShowQ;

//翻译
extern NSString * const APITranslateQ;

//驾考测试
extern NSString * const APIDriverExamQ;

#pragma mark - 聚合

//TV-key
extern NSString * const APITVKey;
//TV-频道列表
extern NSString * const APITVChannelQ;
//TV-节目时间表
extern NSString * const APITVProgramQ;

//Joke-key
extern NSString * const APIJokeKey;
//Joke-文字
extern NSString * const APIJokeTextQ;
//Joke-图片
extern NSString * const APIJokeImgQ;

//History-key
extern NSString * const APIHistoryKey;
//History-历史事件列表
extern NSString * const APIHistoryQueryEventQ;
//History-历史事件详情
extern NSString * const APIHistoryQueryDetailQ;

//Dream-key
extern NSString * const APIDreamKey;
//Dream-查询
extern NSString * const APIDreamQ;

//PostCode-key
extern NSString * const APIPostCodeKey;
//PostCode-搜索
extern NSString * const APIPostCodeSearchQ;

//Bus-key
extern NSString * const APIBusKey;
//Bus-BusLine
extern NSString * const APIBusLineQ;
//Bus-BusStation
extern NSString * const APIBusStationQ;
