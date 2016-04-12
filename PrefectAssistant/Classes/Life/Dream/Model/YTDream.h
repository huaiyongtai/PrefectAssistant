//
//  YTDream.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YTDreamDesFont [UIFont systemFontOfSize:15]

@interface YTDream : NSObject

/**  */
@property (nonatomic, copy) NSString *idString;
/**  */
@property (nonatomic, copy) NSString *title;
/**  */
@property (nonatomic, copy) NSString *des;
/**  */
@property (nonatomic, copy) NSArray *list;


@property (nonatomic, assign) CGRect titleF;
@property (nonatomic, assign) CGRect desF;
@property (nonatomic, assign) CGFloat totalHeight;


//id": "47228eabf463391edd96e428be531761",
//"title": "吃面条",
//"des": "梦到吃面条，预示着身体健康，好事即来。",
//"list":
//[
// 
// "梦到吃面条，预示着身体健康，好事即来。",
// "梦见吃通心面，预示着身体健康，身体免疫力增强。",
// "梦见吃阳春面，意味着异性交友方面运势会上升。"
// 
// ]


@end
