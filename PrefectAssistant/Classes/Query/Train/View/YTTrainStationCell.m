//
//  YTTrainStationCell.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/29.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTTrainStationCell.h"
#import "YTTrainStation.h"

const CGFloat YTTrainStationCellH = 55;

@interface YTTrainStationCell ()
/** 列车编号 */
@property (nonatomic, weak) UILabel *codeLabel;
/** 车站类型，始发、过路、终到*/
@property (nonatomic, weak) UILabel *stationTypeLabel;
/** 列车类型 普快、特快。。。。。*/
@property (nonatomic, weak) UILabel *tTypeLabel;
/** 车站名称 */
@property (nonatomic, weak) UILabel *stationLabel;

/** 终点站 */
@property (nonatomic, weak) UILabel *arriStationLabel;
/** 达到时间 */
@property (nonatomic, weak) UILabel *arriTimeLabel;

/** 始发站 */
@property (nonatomic, weak) UILabel *deptStationLabel;
/** 始发时间 */
@property (nonatomic, weak) UILabel *deptTimeLabel;

@property (nonatomic, weak) UILabel *intervalLabel;

@end

@implementation YTTrainStationCell

+ (instancetype)trainStationWithTableView:(UITableView *)tableView {
    
    static NSString *reuseId = @"YTTrainStationCell";
    YTTrainStationCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;
    
    CGFloat margin = 10;
    CGFloat codeLabelW = (YTSCREEN_W - 2*margin) / 4 - 15;
    CGFloat width = (YTSCREEN_W - codeLabelW-2*margin) / 3;
    CGFloat height = YTTrainStationCellH;
    
    //列车
    UILabel *codeLabel = [[UILabel alloc] init]; {
        [codeLabel setFrame:CGRectMake(margin, 0, codeLabelW, height)];
        [codeLabel setNumberOfLines:0];
        [codeLabel setBackgroundColor:YTRandomColor];
    }
    self.codeLabel = codeLabel;
    [self.contentView addSubview:codeLabel];
    
    //始发
    UILabel *deptStationLabel = [[UILabel alloc] init]; {
        [deptStationLabel setFrame:CGRectMake(codeLabel.rightX, 0, width, height)];
        [deptStationLabel setNumberOfLines:0];
        [deptStationLabel setBackgroundColor:YTRandomColor];
    }
    self.deptStationLabel = deptStationLabel;
    [self.contentView addSubview:deptStationLabel];
   
    //列车
    CGFloat centerH = (height - 2*margin) / 3;
    CGFloat adjustH = 1;
    UILabel *stationLabel = [[UILabel alloc] init]; {
        [stationLabel setFrame:CGRectMake(deptStationLabel.rightX, margin, width, centerH+adjustH)];
        [stationLabel setBackgroundColor:YTRandomColor];
        [stationLabel setFont:[UIFont systemFontOfSize:12]];
        [stationLabel setTextAlignment:NSTextAlignmentCenter];
    }
    [self.contentView addSubview:stationLabel];
    self.stationLabel = stationLabel;
    UIImageView *directionImageView = [[UIImageView alloc] init]; {
        [directionImageView setImage:[UIImage imageNamed:@"chack"]];
        [directionImageView setFrame:CGRectMake(stationLabel.x, stationLabel.bottomY, width, centerH-2*adjustH)];
    }
    [self.contentView addSubview:directionImageView];
    UILabel *intervalLabel = [[UILabel alloc] init]; {
        [intervalLabel setFrame:CGRectMake(stationLabel.x, directionImageView.bottomY, width, centerH+adjustH)];
        [intervalLabel setTextAlignment:NSTextAlignmentCenter];
        [intervalLabel setBackgroundColor:YTRandomColor];
        [intervalLabel setFont:[UIFont systemFontOfSize:10]];
    }
    [self.contentView addSubview:intervalLabel];
    self.intervalLabel = intervalLabel;
    //终点
    UILabel *arriStationLabel = [[UILabel alloc] init]; {
        [arriStationLabel setFrame:CGRectMake(stationLabel.rightX, 0, width, height)];
        [arriStationLabel setTextAlignment:NSTextAlignmentRight];
        [arriStationLabel setNumberOfLines:0];
        [arriStationLabel setBackgroundColor:YTRandomColor];
    }
    self.arriStationLabel = arriStationLabel;
    [self.contentView addSubview:arriStationLabel];
    return self;
}

- (void)setTrainInfo:(YTTrainStation *)trainInfo {
    
    _trainInfo = trainInfo;
   
    [self.codeLabel setAttributedText:({
        NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc]
                                                 initWithString:[trainInfo.code stringByAppendingFormat:@"\n%@", trainInfo.tType]];
        [mAttString setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                            range:NSMakeRange(0, trainInfo.code.length)];
        [mAttString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                            range:NSMakeRange(trainInfo.code.length+1, trainInfo.tType.length)];
        mAttString;
    })];
    
    
    [self.deptStationLabel setAttributedText:({
        NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc]
                                                 initWithString:[trainInfo.deptStation stringByAppendingFormat:@"\n%@", trainInfo.deptTime]];
        [mAttString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                            range:NSMakeRange(0, trainInfo.deptStation.length)];
        [mAttString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                    NSForegroundColorAttributeName:YTColor(100, 100, 100)}
                            range:NSMakeRange(trainInfo.deptStation.length+1, trainInfo.deptTime.length)];
        mAttString;
    })];
    
    [self.arriStationLabel setAttributedText:({
        NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc]
                                                 initWithString:[trainInfo.arriStation stringByAppendingFormat:@"\n%@", trainInfo.arriTime]];
        [mAttString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                            range:NSMakeRange(0, trainInfo.arriStation.length)];
        [mAttString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                    NSForegroundColorAttributeName:YTColor(100, 100, 100)}
                            range:NSMakeRange(trainInfo.arriStation.length+1, trainInfo.arriTime.length)];
        mAttString;
    })];
    
    [self.stationLabel setText:({
        NSString *station = nil;
        if ([trainInfo.stationType isEqualToString:@"过路"]) {
            station = [trainInfo.station stringByAppendingFormat:@"(%@)", trainInfo.stationType];
        }
        station;
    })];
    [self.intervalLabel setText:[NSString stringWithFormat:@"总用时:%@", trainInfo.interval]];
}
@end
