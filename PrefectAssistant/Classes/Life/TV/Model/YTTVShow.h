//
//  YTTVShow.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTTVShow : NSObject

//"channelName" : "BTV科教" ,
//"pId" : 4 ,
//"rel" : "btv3" ,
//"url" : "http://tv.cntv.cn/live/btv3"

/** 节目名称 */
@property (nonatomic, copy) NSString *channelName;

/** 所属分类Id */
@property (nonatomic, copy) NSString *pId;

/**  */
@property (nonatomic, copy) NSString *rel;

/**  */
@property (nonatomic, copy) NSString *url;


@end
