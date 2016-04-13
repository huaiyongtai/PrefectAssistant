//
//  YTBusStationView.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTBusStationView.h"
#import "YTBusStation.h"

@interface YTBusStationView ()

@property (nonatomic, weak) UILabel *fromNameLabel;
@property (nonatomic, weak) UILabel *fromTimeLabel;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *lengthLabel;
@property (nonatomic, weak) UILabel *endNameLabel;
@property (nonatomic, weak) UILabel *endTimeLabel;

@end

@implementation YTBusStationView

+ (instancetype)busStationViewWithTableView:(UITableView *)tableView {
    
    static NSString *reuseId = @"YTBusStationView";
    YTBusStationView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:reuseId];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;
    
    UIView *containView = [[UIView alloc] init]; {
        //Vertical Horizontal
        CGFloat verticalMargin = 5; //垂直间距
        CGFloat horizontalMargin = 5;  //水平间距
        
        CGFloat height = (YTBusStationHeight-verticalMargin) / 3;
        CGFloat width = (YTSCREEN_W - 2*horizontalMargin) / 3;
        
        //首车 列
        UILabel *fromLabel = [[UILabel alloc] init]; {
            [fromLabel setText:@"首车"];
            [fromLabel setFrame:CGRectMake(horizontalMargin, 0, width, height)];
            [fromLabel setTextAlignment:NSTextAlignmentRight];
            [fromLabel setFont:[UIFont systemFontOfSize:15]];
        }
        [containView addSubview:fromLabel];
        
        UILabel *fromNameLabel = [[UILabel alloc] init]; {
            [fromNameLabel setFrame:CGRectMake(horizontalMargin, fromLabel.bottomY, width, height)];
            [fromNameLabel setTextAlignment:NSTextAlignmentRight];
            [fromNameLabel setTextColor:YTColorGrayText];
            [fromNameLabel setFont:[UIFont systemFontOfSize:12]];
        }
        [containView addSubview:fromNameLabel];
        self.fromNameLabel = fromNameLabel;
        
        UILabel *fromTimeLabel = [[UILabel alloc] init]; {
            [fromTimeLabel setFrame:CGRectMake(horizontalMargin, fromNameLabel.bottomY, width, height)];
            [fromTimeLabel setTextAlignment:NSTextAlignmentRight];
            [fromTimeLabel setTextColor:YTColorTintText];
            [fromTimeLabel setFont:[UIFont systemFontOfSize:12]];
        }
        [containView addSubview:fromTimeLabel];
        self.fromTimeLabel = fromTimeLabel;
        
        //中间
        CGFloat adjustH = height*0.2;
        UILabel *nameLabel = [[UILabel alloc] init]; {
            [nameLabel setFrame:CGRectMake(fromLabel.rightX, 0, width, height + adjustH)];
            [nameLabel setTextAlignment:NSTextAlignmentCenter];
            [nameLabel setFont:[UIFont systemFontOfSize:15]];
        }
        [containView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UIImageView *directionView = [[UIImageView alloc] init]; {
            [directionView setFrame:CGRectMake(nameLabel.x, nameLabel.bottomY, width, height - 2*adjustH)];
            [directionView setContentMode:UIViewContentModeScaleAspectFit];
        }
        [containView addSubview:directionView];
        UILabel *lengthLabel = [[UILabel alloc] init]; {
            [lengthLabel setFrame:CGRectMake(directionView.x, directionView.bottomY, width, height + adjustH)];
            [lengthLabel setTextAlignment:NSTextAlignmentCenter];
            [lengthLabel setTextColor:YTColorTintText];
            [lengthLabel setFont:[UIFont systemFontOfSize:12]];
        }
        [containView addSubview:lengthLabel];
        self.lengthLabel = lengthLabel;
        
        //末车 列
        UILabel *endLabel = [[UILabel alloc] init]; {
            [endLabel setText:@"末车"];
            [endLabel setFrame:CGRectMake(nameLabel.rightX, 0, width, height)];
            [endLabel setTextAlignment:NSTextAlignmentLeft];
            [endLabel setFont:[UIFont systemFontOfSize:15]];
        }
        [containView addSubview:endLabel];
        
        UILabel *endNameLabel = [[UILabel alloc] init]; {
            [endNameLabel setFrame:CGRectMake(endLabel.x, endLabel.bottomY, width, height)];
            [endNameLabel setTextAlignment:NSTextAlignmentLeft];
            [endNameLabel setTextColor:YTColorGrayText];
            [endNameLabel setFont:[UIFont systemFontOfSize:12]];
        }
        [containView addSubview:endNameLabel];
        self.endNameLabel = endNameLabel;
        
        UILabel *endTimeLabel = [[UILabel alloc] init]; {
            [endTimeLabel setFrame:CGRectMake(endNameLabel.x, endNameLabel.bottomY, width, height)];
            [endTimeLabel setTextAlignment:NSTextAlignmentLeft];
            [endTimeLabel setTextColor:YTColorTintText];
            [endTimeLabel setFont:[UIFont systemFontOfSize:12]];
        }
        [containView addSubview:endTimeLabel];
        self.endTimeLabel = endTimeLabel;
        
        [containView setBackgroundColor:[UIColor whiteColor]];
        [containView setFrame:CGRectMake(0, verticalMargin, YTSCREEN_W, YTBusStationHeight-verticalMargin)];
    }
    [self.contentView addSubview:containView];
    
    [self.contentView.layer addSublayer:({
        CALayer *lineLayer = [CALayer layer];
        [lineLayer setBackgroundColor:YTColorLineSeparate];
        [lineLayer setFrame:CGRectMake(0, YTBusStationHeight-HLineSeparate, YTSCREEN_W, HLineSeparate)];
        lineLayer;
    })];
    
    [self.contentView setBackgroundColor:YTColorBackground];
    return self;
}

- (void)setBusStation:(YTBusStation *)busStation {
    
    _busStation = busStation;
    
    [self.fromNameLabel setText:busStation.frontName];
    [self.fromTimeLabel setText:busStation.startTime];
    
    [self.nameLabel setText:busStation.keyName];
    [self.lengthLabel setText:busStation.length];
    
    [self.endNameLabel setText:busStation.terminalName];
    [self.endTimeLabel setText:busStation.endTime];
}

@end
