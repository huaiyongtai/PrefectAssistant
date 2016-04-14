//
//  YTTrainHeaderView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainHeaderView.h"
#import "YTTrain.h"
#import "YTTrainSeat.h"

const CGFloat YTTrainHeaderViewH = 80;

@interface YTTrainHeaderView ()

@property (nonatomic, weak) UILabel *startTimeLabel;
@property (nonatomic, weak) UILabel *endTimeLabel;
@property (nonatomic, weak) UILabel *durationLabel;

@property (nonatomic, weak) UILabel *trainNoLabel;
@property (nonatomic, weak) UIButton *fromView;
@property (nonatomic, weak) UIButton *toView;

@property (nonatomic, weak) UILabel *basePriceLabel;

@property (nonatomic, weak) UIButton *revealBtn;
@end

@implementation YTTrainHeaderView

+ (instancetype)trainHeaderViewWith:(UITableView *)tableView {
    
    static NSString *reuseHeaderId = @"YTTrainHeaderView";
    
    YTTrainHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseHeaderId];
    if (headerView == nil) {
        headerView = [[YTTrainHeaderView alloc] initWithReuseIdentifier:reuseHeaderId];
    }
    
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;
    
    //设置背景色
    [self setBackgroundView:({
        UIView *backgroudView = [[UIView alloc] init];
        [backgroudView setBackgroundColor:[UIColor whiteColor]];
        backgroudView;
    })];
    
    UIButton *headerActionBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [headerActionBtn setFrame:CGRectMake(0, 0, YTSCREEN_W, YTTrainHeaderViewH)];
        [headerActionBtn addTarget:self action:@selector(revealSeatInfos) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.contentView addSubview:headerActionBtn];
    
    CGFloat horizontalMargin = 10;  //水平
    CGFloat verticalMargin = 8; //竖直
    CGFloat height = (YTTrainHeaderViewH-2*verticalMargin)/3;
    CGFloat width = (YTSCREEN_W - 5*horizontalMargin) / 3;
    
    //第一列
    UILabel *durationLabel = [[UILabel alloc] init]; {
        [durationLabel setFrame:CGRectMake(horizontalMargin, verticalMargin, width, height)];
        [durationLabel setFont:[UIFont systemFontOfSize:14]];
    }
    [self.contentView addSubview:durationLabel];
    self.durationLabel = durationLabel;
    
    UILabel *startTimeLabel = [[UILabel alloc] init]; {
        [startTimeLabel setFrame:CGRectMake(durationLabel.x, durationLabel.bottomY, width, height)];
        [startTimeLabel setFont:[UIFont systemFontOfSize:14]];
        [startTimeLabel setTextColor:YTColorGrayText];
    }
    [self.contentView addSubview:startTimeLabel];
    self.startTimeLabel = startTimeLabel;
    
    UILabel *endTimeLabel = [[UILabel alloc] init]; {
        [endTimeLabel setFrame:CGRectMake(startTimeLabel.x, startTimeLabel.bottomY, width, height)];
        [endTimeLabel setFont:[UIFont systemFontOfSize:14]];
        [endTimeLabel setTextColor:YTColorGrayText];
    }
    [self.contentView addSubview:endTimeLabel];
    self.endTimeLabel = endTimeLabel;
    
    //第二列
    UILabel *trainNoLabel = [[UILabel alloc] init]; {
        [trainNoLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [trainNoLabel setFrame:CGRectMake(durationLabel.rightX, verticalMargin, width, height)];
    }
    [self.contentView addSubview:trainNoLabel];
    self.trainNoLabel = trainNoLabel;
    
    UIButton *fromView = [[UIButton alloc] init]; {
        [fromView setImage:[UIImage imageNamed:@"fromIcon"] forState:UIControlStateDisabled];
        [fromView setFrame:CGRectMake(trainNoLabel.x, trainNoLabel.bottomY, width, height)];
        [fromView setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [fromView setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
        [fromView setTitleColor:YTColorGrayText forState:UIControlStateDisabled];
        [fromView.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [fromView setEnabled:NO];
    }
    [self.contentView addSubview:fromView];
    self.fromView = fromView;
    
    UIButton *toView = [[UIButton alloc] init]; {
        [toView setImage:[UIImage imageNamed:@"endIcon"] forState:UIControlStateDisabled];
        [toView setFrame:CGRectMake(fromView.x, fromView.bottomY, width, height)];
        [toView setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [toView setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
        [toView setTitleColor:YTColorGrayText forState:UIControlStateDisabled];
        [toView.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [toView setEnabled:NO];
    }
    [self.contentView addSubview:toView];
    self.toView = toView;
    
    //第三列
    CGFloat colThreeHeight = height * 1.5;
    UILabel *basePriceLabel = [[UILabel alloc] init]; {
        [basePriceLabel setTextAlignment:NSTextAlignmentRight];
        [basePriceLabel setFrame:CGRectMake(trainNoLabel.rightX, verticalMargin, width, colThreeHeight)];
        [basePriceLabel setFont:[UIFont systemFontOfSize:15]];
        [basePriceLabel setTextColor:YTColorGrayText];
    }
    [self.contentView addSubview:basePriceLabel];
    self.basePriceLabel = basePriceLabel;
    UIButton *trainNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [trainNumberBtn setFrame:CGRectMake(basePriceLabel.x, basePriceLabel.bottomY, width, colThreeHeight)];
        [trainNumberBtn setTitle:@"车次详情" forState:UIControlStateNormal];
        [trainNumberBtn addTarget:self action:@selector(trainDetail) forControlEvents:UIControlEventTouchUpInside];
        [trainNumberBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [trainNumberBtn setTitleColor:YTColor(73, 147, 207) forState:UIControlStateNormal];
        [trainNumberBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    [self.contentView addSubview:trainNumberBtn];

    //最后列
    UIButton *revealBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        [revealBtn setFrame:CGRectMake(trainNumberBtn.rightX, 0, YTSCREEN_W-trainNumberBtn.rightX, YTTrainHeaderViewH)];
        [revealBtn setImage:[UIImage imageNamed:@"train_arrow_down"] forState:UIControlStateNormal];
        [revealBtn setImage:[UIImage imageNamed:@"train_arrow_up"] forState:UIControlStateSelected];
        [revealBtn addTarget:self action:@selector(revealSeatInfos) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.contentView addSubview:revealBtn];
    self.revealBtn = revealBtn;
    
    CALayer *lineLayer = [CALayer layer]; {
        [lineLayer setFrame:CGRectMake(0, 0, YTSCREEN_W, 0.5)];
        [lineLayer setBackgroundColor:YTColorLineSeparate];
    }
    [self.contentView.layer addSublayer:lineLayer];
    
    return self;
}

- (void)setTrain:(YTTrain *)train {
    
    _train = train;
    
    [self.durationLabel setText:train.duration];
    [self.startTimeLabel setText:train.startTime];
    [self.endTimeLabel setText:train.endTime];
    
    [self.trainNoLabel setText:[train.trainNo stringByAppendingString:train.trainType]];
    [self.fromView setTitle:train.from forState:UIControlStateDisabled];
    [self.toView setTitle:train.to forState:UIControlStateDisabled];
    
    [self.basePriceLabel setText:({
        YTTrainSeat *seat = [train.seatInfos firstObject];
        [NSString stringWithFormat:@"￥%@起", seat.seatPrice];
    })];
    
    self.revealBtn.selected = train.isRevealSeatInfos;
}

- (void)revealSeatInfos {
    
    self.revealBtn.selected = !self.revealBtn.selected;
    if ([self.delegate respondsToSelector:@selector(trainHeaderView:train:didShowRevealseatInfos:)]) {
        [self.delegate trainHeaderView:self train:self.train didShowRevealseatInfos:self.revealBtn.selected];
    }
}

- (void)trainDetail {
    
    if ([self.delegate respondsToSelector:@selector(trainHeaderView:didSelectedTrainNumber:)]) {
        [self.delegate trainHeaderView:self didSelectedTrainNumber:self.train.trainNo];
    }
}

@end
