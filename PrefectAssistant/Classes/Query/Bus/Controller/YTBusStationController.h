//
//  YTBusStationController.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YTBusInfoType) {
    YTBusInfoTypeBusLine,
    YTBusInfoTypeBusStation
};

@interface YTBusStationController : UITableViewController

@property (nonatomic, assign) YTBusInfoType infoType;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *busInfo;


@end
