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
    
    UILabel *titleLabel = [[UILabel alloc] init]; {
        [titleLabel setTextColor:YTColorGrayText];
        [titleLabel setNumberOfLines:0];
    }
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *desLabel = [[UILabel alloc] init]; {
        [desLabel setTextColor:YTColorTintText];
        [desLabel setNumberOfLines:0];
        [desLabel setFont:YTDreamDesFont];
    }
    [self.contentView addSubview:desLabel];
    self.desLabel = desLabel;
    return self;
}

- (void)setDream:(YTDream *)dream {
    
    _dream = dream;
    
    [self.titleLabel setText:dream.title];
    [self.titleLabel setFrame:dream.titleF];
    
    [self.desLabel setText:dream.des];
    [self.desLabel setFrame:dream.desF];
}

@end
