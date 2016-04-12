//
//  YTTrainInfoQuery.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainInfoQuery.h"

@implementation YTTrainInfoQuery

+ (instancetype)trainInfoQueryWithQueryType:(YTTrainInfoQueryTypes)queryType {
    
    return [self trainInfoQueryWithQueryName:nil queryType:queryType];
}

+ (instancetype)trainInfoQueryWithQueryType:(YTTrainInfoQueryTypes)queryType trainNo:(NSString *)trainNo {
    
    YTTrainInfoQuery *query = [[self alloc] init];
    query.queryType = queryType;
    switch (queryType) {
        case YTTrainInfoQueryTypeTrainNo: {
            query.queryName = @"车次查询";
            query.trainNo = trainNo ? : @"G43";
            query.departedTime = [self tomorrowStringWithFormatString:@"YYYY-MM-dd"];
            break;
        }
        case YTTrainInfoQueryTypeStationName: {
            query.queryName = @"车站查询";
            query.stationName = @"西安";
            break;
        }
        case YTTrainInfoQueryTypeStationToStaion: {
            query.queryName = @"站站查询";
            query.startStation = @"北京";
            query.endStation = @"西安";
            query.departedTime = [self tomorrowStringWithFormatString:@"YYYY-MM-dd"];
            break;
        }
    }

    return query;
}

+ (instancetype)trainInfoQueryWithQueryName:(NSString *)queryName queryType:(YTTrainInfoQueryTypes)queryType {
    
    YTTrainInfoQuery *query = [[self alloc] init];
    query.queryType = queryType;
    
    NSString *tempQueryName = queryName;
    if (tempQueryName == nil) {
        switch (queryType) {
            case YTTrainInfoQueryTypeTrainNo: {
                tempQueryName = @"车次查询";
                query.trainNo = @"G43";
                query.departedTime = [self tomorrowStringWithFormatString:@"YYYY-MM-dd"];
                break;
            }
            case YTTrainInfoQueryTypeStationName: {
                tempQueryName = @"车站查询";
                query.stationName = @"西安";
                break;
            }
            case YTTrainInfoQueryTypeStationToStaion: {
                tempQueryName = @"站站查询";
                query.startStation = @"北京";
                query.endStation = @"西安";
                query.departedTime = [self tomorrowStringWithFormatString:@"YYYY-MM-dd"];
                break;
            }
        }
    }
    query.queryName = tempQueryName;
    return query;
}

+ (NSString *)tomorrowStringWithFormatString:(NSString *)formatString {
   
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:formatString];
    return [dateday stringFromDate:({
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                    fromDate:[NSDate date]];
        [components setDay:([components day]+1)];
        [gregorian dateFromComponents:components];
        
    })];
}


@end
