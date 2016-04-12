//
//  YTJoke.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YTJokeContentFont [UIFont systemFontOfSize:16]

@interface YTJoke : NSObject

//"content": "“科学研究发现，睡眠不足会带来许多身心伤害：免疫力下降、\r\n记忆力减弱、易衰老、失去平衡等等，从而引发多种疾病。\r\n从科学角度讲，睡懒觉有助于身心健康。” \r\n“所以，李老师，这就是你在课堂上睡觉的原因？”校长生气的问我。",
//"hashId": "cb01359d7740e19435b9ea4e2d5516a1",
//"unixtime": 1418814837,
//"updatetime": "2014-12-17 19:13:57"

/**  */
@property (nonatomic, copy) NSString *content;
/**  */
@property (nonatomic, copy) NSString *hashId;
/**  */
@property (nonatomic, copy) NSString *unixtime;
/**  */
@property (nonatomic, copy) NSString *updatetime;
/**  */
@property (nonatomic, copy) NSString *url;


@property (nonatomic, assign) CGRect contentF;
@property (nonatomic, assign) CGRect urlF;

@property (nonatomic, assign) CGFloat totalHeight;

@end
