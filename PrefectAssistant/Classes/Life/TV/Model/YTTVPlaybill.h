//
//  YTTVPlaybill.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTTVPlaybill : NSObject

//"cName" : "CCTV世界地理" ,
//"pName" : "世界地理精彩多看点" ,
//"pUrl" : "" ,
//"time" : "2016-04-06 00:27"
/**  */
@property (nonatomic, copy) NSString *cName;
/**  */
@property (nonatomic, copy) NSString *pName;
/**  */
@property (nonatomic, copy) NSString *pUrl;
/**  */
@property (nonatomic, copy) NSString *time;

@end