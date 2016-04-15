//
//  YTTrainSeatCell.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainSeatCell.h"
#import "YTTrainSeat.h"

const CGFloat YTTrainSeatCellH = 30;

@interface YTTrainSeatCell ()

@property (nonatomic, weak) UILabel *seatLabel;
@property (nonatomic, weak) UILabel *seatPriceLabel;
@property (nonatomic, weak) UILabel *remainNumLabel;

@end

@implementation YTTrainSeatCell

+ (instancetype)trainSeatWithTableView:(UITableView *)tableView {
    
    static NSString *reuseId = @"YTTrainSeatCell";
    YTTrainSeatCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    CGFloat margin = 30;
    CGFloat width = (YTSCREEN_W - 2*margin) / 3;
    CGFloat height = YTTrainSeatCellH;
    
    [self.seatLabel setFrame:CGRectMake(margin, 0, width, height)];
    [self.seatPriceLabel setFrame:CGRectMake(self.seatLabel.rightX, 0, width, height)];
    [self.remainNumLabel setFrame:CGRectMake(self.seatPriceLabel.rightX, 0, width, height)];
    
    UILabel *seatLabel = [[UILabel alloc] init]; {
        [seatLabel setTextColor:YTColorGrayText];
        [seatLabel setFont:[UIFont systemFontOfSize:13]];
        [seatLabel setTextAlignment:NSTextAlignmentLeft];
        [seatLabel setFrame:CGRectMake(margin, 0, width, height)];
    }
    [self.contentView addSubview:seatLabel];
    self.seatLabel = seatLabel;
    
    UILabel *seatPriceLabel = [[UILabel alloc] init]; {
        [seatPriceLabel setTextColor:YTColorGrayText];
        [seatPriceLabel setFont:[UIFont systemFontOfSize:13]];
        [seatPriceLabel setTextAlignment:NSTextAlignmentCenter];
        [seatPriceLabel setFrame:CGRectMake(self.seatLabel.rightX, 0, width, height)];
    }
    [self.contentView addSubview:seatPriceLabel];
    self.seatPriceLabel = seatPriceLabel;
    
    UILabel *remainNumLabel = [[UILabel alloc] init]; {
        [remainNumLabel setTextColor:YTColor(200, 60, 60)];
        [remainNumLabel setFont:[UIFont systemFontOfSize:13]];
        [remainNumLabel setTextAlignment:NSTextAlignmentRight];
        [remainNumLabel setFrame:CGRectMake(self.seatPriceLabel.rightX, 0, width, height)];
    }
    [self.contentView addSubview:remainNumLabel];
    self.remainNumLabel = remainNumLabel;
    
    CALayer *lineLayer = [CALayer layer]; {
        [lineLayer setFrame:CGRectMake(12, YTTrainSeatCellH, YTSCREEN_W-12, HLineSeparate)];
        [lineLayer setBackgroundColor:YTColorLineSeparate];
    }
    [self.contentView.layer addSublayer:lineLayer];
    
    return self;
}

- (void)setTrainSeat:(YTTrainSeat *)trainSeat {
    
    _trainSeat = trainSeat;
    
    [self.seatLabel setText:trainSeat.seat];
    [self.seatPriceLabel setText:[NSString stringWithFormat:@"￥%@", trainSeat.seatPrice]];
    [self.remainNumLabel setText:({
        NSString *tempString = nil;
        if (trainSeat.remainNum.integerValue) {
            tempString = [trainSeat.remainNum stringByAppendingString:@"张"];
        } else {
            tempString = @"无";
        }
        tempString;
    })];
}

@end
