//
//  YTBusLine.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const CGFloat YTBusLineHeight;

@interface YTBusLine : NSObject

//"code":"110114",
//"stationNum":"14",
//"name":"朝凤庵村",
//"xy":"116.264772,40.237347"

/**  */
@property (nonatomic, copy) NSString *code;
/**  */
@property (nonatomic, copy) NSString *stationNum;
/**  */
@property (nonatomic, copy) NSString *name;
/**  */
@property (nonatomic, copy) NSString *xy;

@end
