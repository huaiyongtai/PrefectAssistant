//
//  YTMacroDefine.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/14.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//  宏定义

#ifndef YTMacroDefine_h
#define YTMacroDefine_h

/** 颜色*/
#define YTColor(R, G, B)        [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1]
#define YTRandomColor           [UIColor colorWithRed:(arc4random_uniform(255)/255.0) green:(arc4random_uniform(255)/255.0)\
                                 blue:(arc4random_uniform(255)/255.0) alpha:1.0]
#define YTRGBAColor(R, G, B, A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

/** 获取硬件信息*/
#define YTSCREENBounds  [UIScreen mainScreen].bounds
#define YTSCREEN_W      [UIScreen mainScreen].bounds.size.width
#define YTSCREEN_H      [UIScreen mainScreen].bounds.size.height
#define YTSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#endif /* YTMacroDefine_h */
