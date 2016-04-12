//
//  YTDish.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/22.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const CGFloat YTDishHeight;

@interface YTDish : NSObject

//count = 165;
//description = "还适宜癌症患者及放疗化疗后，糖尿病，肝硬化腹水，肺结核，慢性肾炎浮肿者食用";
//fcount = 0;
//food = "鸭子,土豆,芹菜,啤酒";
//id = 13783;
//images = "";
//img = "/cook/080222/980d43882196d6887dfcbd4dd16cec23.jpg";
//keywords = "食用 大火 煮开 土豆 倒入 ";
//name = "啤酒鸭";
//rcount = 0;

/**  */
@property (nonatomic, copy) NSString *count;
/** 菜品概述 */
@property (nonatomic, copy) NSString *descStr;

/**  */
@property (nonatomic, copy) NSString *fcount;

/** 制作材料 */
@property (nonatomic, copy) NSString *food;

/** id标识符 */
@property (nonatomic, copy) NSString *idStr;

/**  */
@property (nonatomic, copy) NSString *images;

/** 菜品预览图 */
@property (nonatomic, copy) NSString *img;

/** 菜名 */
@property (nonatomic, copy) NSString *name;

/**  */
@property (nonatomic, copy) NSString *keywords;

/**  */
@property (nonatomic, copy) NSString *rcount;


@end
