//
//  YTDishCell.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/23.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTDishCell.h"
#import "YTDish.h"
#import <UIImageView+WebCache.h>

@interface YTDishCell ()

/**  */
//@property (nonatomic, weak) UILabel *nameLabel;
/**  */
@property (nonatomic, weak) UILabel *dishInfoLabel;
/**  */
@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation YTDishCell

+ (instancetype)dishCellWithTableView:(UITableView *)tableView {
    
    static NSString *reuseId = @"YTDishCell";
    YTDishCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;
    
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    UILabel *dishInfoLabel = [[UILabel alloc] init];
    {
        [dishInfoLabel setNumberOfLines:0];
    }
    [self.contentView addSubview:dishInfoLabel];
    self.dishInfoLabel = dishInfoLabel;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    {
        [imgView setContentMode:UIViewContentModeScaleAspectFill];
        [imgView setClipsToBounds:YES];
    }
    [self.contentView addSubview:imgView];
    self.imgView = imgView;

    return self;
}

- (void)setDish:(YTDish *)dish {
    
    _dish = dish;
    [self.imgView sd_setImageWithURL:({
        NSString *urlStr = [@"http://tnfs.tngou.net/image" stringByAppendingPathComponent:dish.img];
        [NSURL URLWithString:urlStr];
    })];
    
    [self.dishInfoLabel setAttributedText:({
        NSString *dishInfoStr = [NSString stringWithFormat:@"%@\n%@", dish.name, dish.keywords];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:dishInfoStr];
        [attString setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} range:NSMakeRange(0, dish.name.length)];
        [attString setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} range:NSMakeRange(dish.name.length, dish.keywords.length)];
        attString;
    })];}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat horizontalMargin = 10;  //水平
    CGFloat verticalMargin = 10;    //竖直间距
    CGFloat imageViewW = 120;
    CGFloat imageViewH = (YTDishHeight - 2*verticalMargin);
    [self.imgView setFrame:CGRectMake(horizontalMargin, verticalMargin, imageViewW, imageViewH)];
    
    CGFloat dishInfoLableW = self.contentView.width - self.imgView.rightX - horizontalMargin;
    [self.dishInfoLabel setFrame:CGRectMake(self.imgView.rightX + horizontalMargin, verticalMargin, dishInfoLableW, imageViewH)];
}



@end
