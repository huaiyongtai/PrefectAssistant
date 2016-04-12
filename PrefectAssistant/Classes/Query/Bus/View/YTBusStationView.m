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
    
    //Vertical Horizontal
    CGFloat verticalMargin = 5; //垂直间距
    CGFloat horizontalMargin = 8;  //水平间距
    
    CGFloat height = (YTBusStationHeight-2*verticalMargin) / 3;
    CGFloat width = (YTSCREEN_W - 2*horizontalMargin) / 4;
    
    //首车 列
    UILabel *fromLabel = [[UILabel alloc] init]; {
        [fromLabel setText:@"首车"];
        [fromLabel setFrame:CGRectMake(horizontalMargin, verticalMargin, width, height)];
        [fromLabel setTextAlignment:NSTextAlignmentRight];
        [fromLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:fromLabel];
    
    UILabel *fromNameLabel = [[UILabel alloc] init]; {
        [fromNameLabel setFrame:CGRectMake(horizontalMargin, fromLabel.bottomY, width, height)];
        [fromNameLabel setTextAlignment:NSTextAlignmentRight];
        [fromNameLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:fromNameLabel];
    self.fromNameLabel = fromNameLabel;
    
    UILabel *fromTimeLabel = [[UILabel alloc] init]; {
        [fromTimeLabel setFrame:CGRectMake(horizontalMargin, fromNameLabel.bottomY, width, height)];
        [fromTimeLabel setTextAlignment:NSTextAlignmentRight];
        [fromTimeLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:fromTimeLabel];
    self.fromTimeLabel = fromTimeLabel;
    
    //中间
    CGFloat adjustH = height*0.2;
    UILabel *nameLabel = [[UILabel alloc] init]; {
        [nameLabel setFrame:CGRectMake(fromLabel.rightX, verticalMargin, 2*width, height + adjustH)];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [nameLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIImageView *directionView = [[UIImageView alloc] init]; {
        [directionView setFrame:CGRectMake(nameLabel.x, nameLabel.bottomY, 2*width, height - 2*adjustH)];
        [directionView setContentMode:UIViewContentModeScaleAspectFit];
        [directionView setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:directionView];
    UILabel *lengthLabel = [[UILabel alloc] init]; {
        [lengthLabel setFrame:CGRectMake(directionView.x, directionView.bottomY, 2*width, height + adjustH)];
        [lengthLabel setTextAlignment:NSTextAlignmentCenter];
        [lengthLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:lengthLabel];
    self.lengthLabel = lengthLabel;
    
    //末车 列
    UILabel *endLabel = [[UILabel alloc] init]; {
        [endLabel setText:@"末车"];
        [endLabel setFrame:CGRectMake(nameLabel.rightX, verticalMargin, width, height)];
        [endLabel setTextAlignment:NSTextAlignmentLeft];
        [endLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:endLabel];
    
    UILabel *endNameLabel = [[UILabel alloc] init]; {
        [endNameLabel setFrame:CGRectMake(endLabel.x, endLabel.bottomY, width, height)];
        [endNameLabel setTextAlignment:NSTextAlignmentLeft];
        [endNameLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:endNameLabel];
    self.endNameLabel = endNameLabel;
    
    UILabel *endTimeLabel = [[UILabel alloc] init]; {
        [endTimeLabel setFrame:CGRectMake(endNameLabel.x, endNameLabel.bottomY, width, height)];
        [endTimeLabel setTextAlignment:NSTextAlignmentLeft];
        [endTimeLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:endTimeLabel];
    self.endTimeLabel = endTimeLabel;

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
