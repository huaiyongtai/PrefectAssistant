//
//  YTBusLineCell.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTBusLineCell.h"
#import "YTBusLine.h"

@interface YTBusLineCell ()

@property (nonatomic, weak) UILabel *stationNumLabel;
@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation YTBusLineCell

+ (instancetype)busLineCellWithTableView:(UITableView *)tableView {
    
    static NSString *reuseId = @"YTBusLineCell";
    YTBusLineCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    CALayer *layerLine = [[CALayer alloc] init]; {
        [layerLine setFrame:CGRectMake(20, 0, 1, YTBusLineHeight)];
        [layerLine setBackgroundColor:YTColor(0, 172, 211).CGColor];
    }
    [self.contentView.layer addSublayer:layerLine];
    
    UIImageView *dotImageView = [[UIImageView alloc] init]; {
        CGFloat dotWH = 12;
        [dotImageView setFrame:CGRectMake(CGRectGetMinX(layerLine.frame)-dotWH*0.5, (CGRectGetHeight(layerLine.frame)-dotWH)*0.5, dotWH, dotWH)];
        [dotImageView setImage:[UIImage imageNamed:@"icon_dot"]];
    }
    [self.contentView addSubview:dotImageView];
    
    CGFloat margin = 15;
    UILabel *stationNumLabel = [[UILabel alloc] init]; {
        [stationNumLabel setFrame:CGRectMake(dotImageView.rightX+margin, 0, 30, YTBusLineHeight)];
        [stationNumLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:stationNumLabel];
    self.stationNumLabel = stationNumLabel;
    
    UILabel *nameLabel = [[UILabel alloc] init]; {
        [nameLabel setFrame:CGRectMake(stationNumLabel.rightX+margin, 0, 150, YTBusLineHeight)];
        [nameLabel setBackgroundColor:YTRandomColor];
    }
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    return self;
}

- (void)setBusLine:(YTBusLine *)busLine {
    
    _busLine = busLine;
    
    [self.stationNumLabel setText:busLine.stationNum];
    [self.nameLabel setText:busLine.name];
}

@end
