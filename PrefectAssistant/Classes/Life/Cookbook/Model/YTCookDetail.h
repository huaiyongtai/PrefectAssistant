//
//  YTCookDetail.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/22.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTCookDetail : NSObject

//"count": 4182,
//"description": "除黄油外，其他材料混合揉成光滑面团，摊开面团，加入融化的黄油，继续揉面至可拉开坚韧的薄膜，收圆入盆，基础发酵．2",
//"fcount": 0,
//"food": "面粉,杞枣粉,酵母,蛋液,牛奶,黄油",
//"id": 10,
//"images": "",
//"img": "/cook/150802/79b05ad0532a0ef682ae920ff9b67764.jpg",
//"keywords": "发酵 面团 黄油 完成后 最后 ",
//"message": "<h2>菜谱简介</h2><hr>     <h2>材料 </h2><hr>  \n<p>面粉200克，杞枣粉20克，酵母2克，糖20克，盐3克，蛋液20克，牛奶100克，黄油8克</p>   <h2>做法 </h2><hr>  \n<p>1. 除黄油外，其他材料混合揉成光滑面团，摊开面团，加入融化的黄油，继续揉面至可拉开坚韧的薄膜，收圆入盆，基础发酵． </p> \n<p>2. 基础发酵完成后，排气，取出，分割四等份，滚圆，覆盖，中间发酵15分钟． </p> \n<p>3. 取一个面团，擀开，翻面，从上往下紧密卷起，收口处捏紧，用手轻轻搓揉成橄榄形． </p> \n<p>4. 间隔排放入铺垫好的烤盘上，入烤箱做最后发酵． </p> \n<p>5. 最后发酵完成后，刷蛋液，用刀片划开一道口（可省略） </p> \n<p>6. 烤箱180度预热好，中层，15分钟（上色均匀后盖锡纸）</p>",
//"name": "杞枣餐包",
//"rcount": 0,
//"status": true,
//"url": "http://www.tngou.net/cook/show/10"

/**  */
@property (nonatomic, copy) NSString *count;
/**  */
@property (nonatomic, copy) NSString *descStr;
/**  */
@property (nonatomic, copy) NSString *fcount;
/**  */
@property (nonatomic, copy) NSString *food;
/**  */
@property (nonatomic, copy) NSString *idStr;
/**  */
@property (nonatomic, copy) NSString *images;
/**  */
@property (nonatomic, copy) NSString *img;
/**  */
@property (nonatomic, copy) NSString *keywords;
/**  */
@property (nonatomic, copy) NSString *message;
/**  */
@property (nonatomic, copy) NSString *name;
/**  */
@property (nonatomic, copy) NSString *rcount;
/**  */
@property (nonatomic, copy) NSString *status;
/**  */
@property (nonatomic, copy) NSString *url;

@end
