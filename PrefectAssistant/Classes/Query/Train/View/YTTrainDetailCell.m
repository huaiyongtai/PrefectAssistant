//
//  YTTrainDetailCell.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainDetailCell.h"
#import "YTTrainDetailView.h"

@interface YTTrainDetailCell ()

@property (nonatomic, strong) YTTrainDetailView *trainDetailView;

@end

@implementation YTTrainDetailCell

+ (instancetype)trainDetailCellWithTableView:(UITableView *)tableView {

    static NSString *reuseId = @"YTTrainDetailCell";
    
    YTTrainDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[YTTrainDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;;
    
    YTTrainDetailView *detailView = [YTTrainDetailView trainDetailView];
    self.trainDetailView = detailView;
    [self.contentView addSubview:detailView];
    
    return self;
}

- (void)setTrainRowTimetables:(NSArray *)trainRowTimetables {
    
    _trainRowTimetables = [trainRowTimetables copy];
    
    self.trainDetailView.trainRowTimetables = trainRowTimetables;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.trainDetailView setFrame:self.bounds];
}

@end