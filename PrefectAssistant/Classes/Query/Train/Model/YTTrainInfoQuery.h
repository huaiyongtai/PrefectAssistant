//
//  YTTrainInfoQuery.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YTTrainInfoQueryTypes) {
    YTTrainInfoQueryTypeTrainNo,        //车次查询
    YTTrainInfoQueryTypeStationName,    //车站查询
    YTTrainInfoQueryTypeStationToStaion,//站站查询
};

@interface YTTrainInfoQuery : NSObject

@property (nonatomic, assign) YTTrainInfoQueryTypes queryType;
@property (nonatomic, copy) NSString *queryName;

@property (nonatomic, copy) NSString *startStation; //起始站
@property (nonatomic, copy) NSString *endStation;

@property (nonatomic, copy) NSString *trainNo;

@property (nonatomic, copy) NSString *stationName;

@property (nonatomic, copy) NSString *departedTime;

+ (instancetype)trainInfoQueryWithQueryType:(YTTrainInfoQueryTypes)queryType;
+ (instancetype)trainInfoQueryWithQueryType:(YTTrainInfoQueryTypes)queryType trainNo:(NSString *)trainNo;
@end
