//
//  YTBusStation.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YTBusLine;

extern const CGFloat YTBusStationHeight;

@interface YTBusStation : NSObject

//"line_id":"1100000102",
//"name":"１０路（北京站东－南菜园）",
//"key_name":"１０路",
//"front_name":"北京站东",
//"terminal_name":"南菜园",
//"start_time":"0500",
//"end_time":"0000",
//"basic_price":"0.000000",
//"total_price":"1.000000",
//"company":"北京公交集团第四客运分公司",
//"length":"11.091000"

//"stationdes":[

/**  */
@property (nonatomic, copy) NSString *lineId;
/**  */
@property (nonatomic, copy) NSString *name;
/**  */
@property (nonatomic, copy) NSString *keyName;
/**  */
@property (nonatomic, copy) NSString *frontName;
/**  */
@property (nonatomic, copy) NSString *terminalName;
/**  */
@property (nonatomic, copy) NSString *startTime;
/**  */
@property (nonatomic, copy) NSString *endTime;
/**  */
@property (nonatomic, copy) NSString *length;
/**  */
@property (nonatomic, copy) NSString *company;
/**  */
@property (nonatomic, copy) NSArray<YTBusLine *> *stationdes;

@end
