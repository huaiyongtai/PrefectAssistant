//
//  YTJoke.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTJoke.h"

@implementation YTJoke

- (void)mj_keyValuesDidFinishConvertingToObject {
    

    CGFloat margin = 8;
    
    CGFloat width = YTSCREEN_W - 2*margin;
    CGSize realSize = [self.content boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : YTJokeContentFont} context:nil].size;
    self.contentF = CGRectMake(margin, margin, width, realSize.height);
    
    if (self.url.length) {
        self.urlF = CGRectMake(margin, CGRectGetMaxY(self.contentF) + margin, width, 200);
        self.totalHeight = CGRectGetMaxY(self.urlF) + margin;
    } else {
        self.totalHeight = CGRectGetMaxY(self.contentF) + margin;
    }
}

@end
