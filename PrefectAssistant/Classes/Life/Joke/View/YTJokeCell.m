//
//  YTJokeCell.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTJokeCell.h"
#import "YTJoke.h"
#import <UIImageView+WebCache.h>
#import "YTPreviewView.h"

@interface YTJokeCell ()

@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIImageView *urlImgView;

@end

@implementation YTJokeCell

+ (instancetype)jokeCellWithTableView:(UITableView *)tableView {
    
    static NSString *reuseId = @"YTJokeCell";
    YTJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self == nil) return nil;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *contentLabel = [[UILabel alloc] init]; {
        [contentLabel setFont:YTJokeContentFont];
        [contentLabel setBackgroundColor:YTRandomColor];
        [contentLabel setNumberOfLines:0];
    }
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIImageView *urlImgView = [[UIImageView alloc] init]; {
        [urlImgView setContentMode:UIViewContentModeScaleAspectFit];
        [urlImgView setBackgroundColor:YTRandomColor];
        [urlImgView setUserInteractionEnabled:YES];
        [urlImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewJokeImg:)]];
    }
    [self.contentView addSubview:urlImgView];
    self.urlImgView = urlImgView;

    return self;
}


- (void)setJoke:(YTJoke *)joke {
    
    _joke = joke;

    [self.contentLabel setText:joke.content];
    [self.contentLabel setFrame:joke.contentF];
    
    [self.urlImgView setHidden:!(joke.url.length>0)];
    if (joke.url.length) {
        [self.urlImgView sd_setImageWithURL:[NSURL URLWithString:joke.url]];
        [self.urlImgView setFrame:joke.urlF];
        [self.contentLabel setTextAlignment:NSTextAlignmentCenter];
    } else {
        [self.contentLabel setTextAlignment:NSTextAlignmentLeft];
    }
}

- (void)previewJokeImg:(UIGestureRecognizer *)gesture {
 
    YTPreviewView *preview = [[YTPreviewView alloc] init];
    [preview showImageWithURLString:self.joke.url FromvView:gesture.view];
}

@end
