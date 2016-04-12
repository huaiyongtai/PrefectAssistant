//
//  YTTrainStation.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTTrainStation : NSObject

//8351 =             {
//    arriCity = "西安";
//    "arriCity_py" = xian;
//    arriStation = "西安";
//    arriStationInfo = 1;
//    arriTime = "09:52";
//    arriTimeRange = "上午";
//    code = 8351;
//    dayAfter = 1;
//    deptCity = "渭南";
//    "deptCity_py" = weinan;
//    deptStation = "渭南";
//    deptStationInfo = 0;
//    deptTime = "08:17";
//    deptTimeRange = "上午";
//    interval = "1小时35分";
//    intervalSort = 95;
//    istmp = 0;
//    sort = 54;
//    station = "西安";
//    stationType = "终到";
//    tType = "普快";
//    ticketType =                 (
//                                  "硬座"
//                                  );
//    trainType = "其他";
//};
//
//"K558/K559" =             {
//    arriCity = "上海";
//    "arriCity_py" = shanghai;
//    arriStation = "上海";
//    arriStationInfo = 0;
//    arriTime = "13:49";
//    arriTimeRange = "中午";
//    code = "K558/K559";
//    dayAfter = 2;
//    deptCity = "延安";
//    "deptCity_py" = yanan;
//    deptStation = "延安";
//    deptStationInfo = 0;
//    deptTime = "13:20";
//    deptTimeRange = "中午";
//    interval = "1天29分";
//    intervalSort = 1469;
//    istmp = 0;
//    sort = 316;
//    station = "西安";
//    stationType = "过路";
//    tType = "快速";
//    ticketType =                 (
//                                  "硬座",
//                                  "硬卧",
//                                  "软卧"
//                                  );
//    trainType = "快速";
//};



/** 列车编号 */
@property (nonatomic, copy) NSString *code;
/** 车站类型，始发、过路、终到*/
@property (nonatomic, copy) NSString *stationType;
/** 列车类型 普快、特快。。。。。*/
@property (nonatomic, copy) NSString *tType;
/** 车站名称 */
@property (nonatomic, copy) NSString *station;

/** 终点站 */
@property (nonatomic, copy) NSString *arriStation;
/** 达到时间 */
@property (nonatomic, copy) NSString *arriTime;

/** 始发站 */
@property (nonatomic, copy) NSString *deptStation;
/** 始发时间 */
@property (nonatomic, copy) NSString *deptTime;

/** 始发时间 */
@property (nonatomic, copy) NSString *interval;

@end
