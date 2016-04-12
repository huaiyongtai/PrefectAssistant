//
//  YTProvince.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/8.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTDistrict : NSObject

/**  */
@property (nonatomic, copy) NSString *idString;

@property (nonatomic, copy) NSString *name;

@end


@interface YTCity : NSObject

/**  */
@property (nonatomic, copy) NSString *idString;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSArray<YTDistrict *> *districts;

@end

@interface YTProvince : NSObject

/**  */
@property (nonatomic, copy) NSString *idString;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSArray<YTCity *> *cities;


@end
