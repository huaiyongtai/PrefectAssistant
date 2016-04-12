//
//  YTCookKindItem.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/22.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTCookKindItem : NSObject

/**
 cookclass = 0;
 description = "美容";
 id = 1;
 keywords = "美容";
 name = "美容";
 seq = 0;
 title = "美容";
 */

/**  */
@property (nonatomic, copy) NSString *cookclass;

/** 描述 */
@property (nonatomic, copy) NSString *descStr;

/** id标识符 */
@property (nonatomic, copy) NSString *idStr;

/** 关键字 */
@property (nonatomic, copy) NSString *keywords;

/** 分类名称 */
@property (nonatomic, copy) NSString *name;

/**  */
@property (nonatomic, copy) NSString *seq;

/**  */
@property (nonatomic, copy) NSString *title;

@end
