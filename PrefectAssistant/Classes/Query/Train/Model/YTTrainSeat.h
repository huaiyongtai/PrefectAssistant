//
//  YTTrainSeat.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTTrainSeat : NSObject

//remainNum = 646;
//seat = "硬座";
//seatPrice = "148.5";

/** 余票数 */
@property (nonatomic, copy) NSString *remainNum;

/** 座位名称 */
@property (nonatomic, copy) NSString *seat;

/** 票价 */
@property (nonatomic, copy) NSString *seatPrice;

@end
