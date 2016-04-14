//
//  YTDreamCell.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTDreamCell.h"
#import "YTDream.h"

@interface YTDreamCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *desLabel;

@property (nonatomic, weak) UIView *containView;

@end

@implementation YTDreamCell

+ (instancetype)dreamCellWithTableView:(UITableView *)tableView {
    
    static NSString *reuseId = @"YTDreamCell";
    YTDreamCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return self;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIView *containView = [[UIView alloc] init]; {

        [containView setBackgroundColor:[UIColor whiteColor]];
        [containView.layer addSublayer:({
            CALayer *lineLayer = [CALayer layer];
            [lineLayer setBackgroundColor:YTColorLineSeparate];
            [lineLayer setFrame:CGRectMake(0, 0, YTSCREEN_W, HLineSeparate)];
            lineLayer;
        })];
        
        UILabel *titleLabel = [[UILabel alloc] init]; {
            [titleLabel setTextColor:YTColorGrayText];
            [titleLabel setNumberOfLines:0];
        }
        [containView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *desLabel = [[UILabel alloc] init]; {
            [desLabel setTextColor:YTColorTintText];
            [desLabel setNumberOfLines:0];
            [desLabel setFont:YTDreamDesFont];
        }
        [containView addSubview:desLabel];
        self.desLabel = desLabel;
    }
    [self.contentView addSubview:containView];
    self.containView = containView;
    
    [self.contentView setBackgroundColor:YTColorBackground];
    
    return self;
}

- (void)setDream:(YTDream *)dream {
    
    _dream = dream;
    
    [self.titleLabel setText:dream.title];
    [self.titleLabel setFrame:dream.titleF];
    
    [self.desLabel setText:dream.des];
    [self.desLabel setFrame:dream.desF];
    
    [self.containView setFrame:CGRectMake(0, 10, YTSCREEN_W, self.desLabel.bottomY)];
}

@end
