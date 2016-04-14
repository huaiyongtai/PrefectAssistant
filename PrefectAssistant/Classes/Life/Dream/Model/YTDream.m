//
//  YTDream.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTDream.h"

@implementation YTDream

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"idString" : @"id"};
}


- (void)mj_keyValuesDidFinishConvertingToObject {
    
    self.des = [self.list componentsJoinedByString:@"\n"];
    
    CGFloat topMargin = 10; //分割
    CGFloat horizontalMargin = 10;  //水平间距
    self.titleF = CGRectMake(horizontalMargin, 0, YTSCREEN_W-2*horizontalMargin, 27);
    self.desF = ({
    
        CGSize desSize = [self.des boundingRectWithSize:CGSizeMake(YTSCREEN_W-2*horizontalMargin, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName : YTDreamDesFont}
                                                context:nil].size;
        CGRectMake(horizontalMargin, CGRectGetMaxY(self.titleF), YTSCREEN_W-2*horizontalMargin, desSize.height + topMargin);
    });
    
    
    self.totalHeight = CGRectGetMaxY(self.desF) + topMargin;
}



@end
