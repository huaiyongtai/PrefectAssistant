//
//  YTTrainDetailView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainDetailView.h"

@interface YTTrainDetailView ()

@property (nonatomic, strong) NSMutableArray<UILabel *> *trainTimetableLabels;

@end

@implementation YTTrainDetailView

+ (instancetype)trainDetailView {
    
    YTTrainDetailView *trainDetailView = [[self alloc] init];
    trainDetailView.trainTimetableLabels = [NSMutableArray array];
    [trainDetailView setBackgroundColor:[UIColor whiteColor]];
    return trainDetailView;
}

- (void)setTrainRowTimetables:(NSArray *)trainRowTimetables {
    
    _trainRowTimetables = [trainRowTimetables copy];
    
    
    while (6>self.trainTimetableLabels.count) {
        UILabel *rowTimeLabel = [[UILabel alloc] init];
//        [rowTimeLabel setBackgroundColor:YTRandomColor];
        [rowTimeLabel setFont:[UIFont systemFontOfSize:12]];
        [rowTimeLabel setTextColor:YTColorGrayText];
        [rowTimeLabel setTextAlignment:NSTextAlignmentCenter];
        [_trainTimetableLabels addObject:rowTimeLabel];
        [self addSubview:rowTimeLabel];
    }
    
    [self.trainTimetableLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= self.trainRowTimetables.count) {
            obj.hidden = YES;
        } else {
            obj.hidden = NO;
            NSUInteger aIndex = (idx>1 ? (idx+1) : idx);  //不需要第二条数据，即下标为1的数据
            obj.text = trainRowTimetables[aIndex];
        }
    }];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat margin = 2;
    CGFloat width = (self.width-2*margin)/self.trainTimetableLabels.count;
    CGFloat height = self.height;
    [self.trainTimetableLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx >= self.trainRowTimetables.count) {
            *stop = YES;
        } else {
            [obj setFrame:CGRectMake(margin + idx*width, 0, width, height)];
        }
    }];
}

@end
