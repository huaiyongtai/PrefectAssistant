//
//  YTTrain.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    duration = "11小时34分";
//    endTime = "08:15";
//    from = "北京西";
//    startTime = "20:41";
//    to = "西安";
//    trainNo = Z19;
//    trainType = "直达特快";
//    seatInfos = (
//         {
//             remainNum = 0;
//             seat = "硬卧上";
//             seatPrice = "254.5";
//         },
//         {
//             remainNum = 0;
//             seat = "硬卧中";
//             seatPrice = "263.5";
//         }
//         );
//}
@class YTTrainSeat;

@interface YTTrain : NSObject

/** 列车编号 */
@property (nonatomic, copy) NSString *trainNo;
/** 列车类型 */
@property (nonatomic, copy) NSString *trainType;
/** 发时 */
@property (nonatomic, copy) NSString *startTime;
/** 到时 */
@property (nonatomic, copy) NSString *endTime;
/** 历时 */
@property (nonatomic, copy) NSString *duration;
/** 始发站 */
@property (nonatomic, copy) NSString *from;
/** 终点站 */
@property (nonatomic, copy) NSString *to;
/** 座位信息模型数字 */
@property (nonatomic, copy) NSArray<YTTrainSeat *> *seatInfos;

@property (nonatomic, assign, getter=isRevealSeatInfos) BOOL revealSeatInfos;

@end
