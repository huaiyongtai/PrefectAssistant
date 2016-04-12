//
//  YTTrainDetailView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTTrainDetailView : UIView

@property (nonatomic, copy) NSArray<NSString *> *trainRowTimetables;

+ (instancetype)trainDetailView;

@end
