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
    
    CGFloat margin = 30;
    CGFloat width = (YTSCREEN_W - 2*margin) / 3;
    CGFloat height = YTTrainSeatCellH;
    
    [self.seatLabel setFrame:CGRectMake(margin, 0, width, height)];
    [self.seatPriceLabel setFrame:CGRectMake(self.seatLabel.rightX, 0, width, height)];
    [self.remainNumLabel setFrame:CGRectMake(self.seatPriceLabel.rightX, 0, width, height)];
    
    UILabel *seatLabel = [[UILabel alloc] init]; {
        [seatLabel setTextColor:YTColor(60, 60, 60)];
        [seatLabel setFont:[UIFont systemFontOfSize:14]];
        [seatLabel setTextAlignment:NSTextAlignmentLeft];
        [seatLabel setFrame:CGRectMake(margin, 0, width, height)];
    }
    [self.contentView addSubview:seatLabel];
    self.seatLabel = seatLabel;
    
    UILabel *seatPriceLabel = [[UILabel alloc] init]; {
        [seatPriceLabel setTextColor:YTColor(60, 60, 60)];
        [seatPriceLabel setFont:[UIFont systemFontOfSize:14]];
        [seatPriceLabel setTextAlignment:NSTextAlignmentCenter];
        [seatPriceLabel setFrame:CGRectMake(self.seatLabel.rightX, 0, width, height)];
    }
    [self.contentView addSubview:seatPriceLabel];
    self.seatPriceLabel = seatPriceLabel;
    
    UILabel *remainNumLabel = [[UILabel alloc] init]; {
        [remainNumLabel setTextColor:YTColor(200, 60, 60)];
        [remainNumLabel setFont:[UIFont systemFontOfSize:14]];
        [remainNumLabel setTextAlignment:NSTextAlignmentRight];
        [remainNumLabel setFrame:CGRectMake(self.seatPriceLabel.rightX, 0, width, height)];
    }
    [self.contentView addSubview:remainNumLabel];
    self.remainNumLabel = remainNumLabel;
    
    CALayer *lineLayer = [CALayer layer]; {
        [lineLayer setFrame:CGRectMake(0, YTTrainSeatCellH-0.5, YTSCREEN_W, 0.5)];
        [lineLayer setBackgroundColor:YTColor(200, 200, 200).CGColor];
    }
    [self.contentView.layer addSublayer:lineLayer];
    
    return self;
}

- (void)setTrainSeat:(YTTrainSeat *)trainSeat {
    
    _trainSeat = trainSeat;
    [self.seatLabel setText:trainSeat.seat];
    [self.seatPriceLabel setText:[NSString stringWithFormat:@"￥%@", trainSeat.seatPrice]];
    [self.remainNumLabel setText:[trainSeat.remainNum stringByAppendingString:@"张"]];
}

@end
