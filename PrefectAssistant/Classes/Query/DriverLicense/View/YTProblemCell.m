//
//  YTProblemCell.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/1.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTProblemCell.h"
#import "YTProblem.h"
#import <UIImageView+WebCache.h>

@interface YTProblemCell ()

/**  */
@property (nonatomic, weak) UILabel *questionLabel;
/**  */
@property (nonatomic, weak) UIButton *item1Btn;
/**  */
@property (nonatomic, weak) UIButton *item2Btn;
/**  */
@property (nonatomic, weak) UIButton *item3Btn;
/**  */
@property (nonatomic, weak) UIButton *item4Btn;

/**  */
@property (nonatomic, weak) UILabel *explainsLabel;
/**  */
@property (nonatomic, weak) UIImageView *urlImageView;

@property (nonatomic, weak) UIScrollView *containView;

@end

@implementation YTProblemCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self == nil) return nil;

    UIScrollView *containView = [[UIScrollView alloc] init]; {
    
        [containView setBackgroundColor:YTRandomColor];
        [containView setFrame:self.bounds];
        [containView setShowsVerticalScrollIndicator:NO];
        [containView setShowsHorizontalScrollIndicator:NO];
        
        UILabel *questionLabel = [[UILabel alloc] init]; {
            [questionLabel setBackgroundColor:YTRandomColor];
            [questionLabel setNumberOfLines:0];
        }
        [containView addSubview:questionLabel];
        self.questionLabel = questionLabel;
        
        UIImageView *urlImageView = [[UIImageView alloc] init]; {
            [urlImageView setContentMode:UIViewContentModeScaleAspectFit];
            [urlImageView setBackgroundColor:YTRandomColor];
        }
        [containView addSubview:urlImageView];
        self.urlImageView = urlImageView;
        
        UIButton *item1Btn = [[UIButton alloc] init]; {
            [item1Btn setBackgroundColor:YTRandomColor];
            [item1Btn.titleLabel setNumberOfLines:0];
            [item1Btn setTag:1];
            [item1Btn addTarget:self action:@selector(itemBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [containView addSubview:item1Btn];
        self.item1Btn = item1Btn;
        
        UIButton *item2Btn = [[UIButton alloc] init]; {
            [item2Btn setBackgroundColor:YTRandomColor];
            [item2Btn.titleLabel setNumberOfLines:0];
            [item2Btn setTag:2];
            [item2Btn addTarget:self action:@selector(itemBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [containView addSubview:item2Btn];
        self.item2Btn = item2Btn;
        
        UIButton *item3Btn = [[UIButton alloc] init]; {
            [item3Btn setBackgroundColor:YTRandomColor];
            [item3Btn.titleLabel setNumberOfLines:0];
            [item3Btn setTag:3];
            [item3Btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [item3Btn addTarget:self action:@selector(itemBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [containView addSubview:item3Btn];
        self.item3Btn = item3Btn;
        
        UIButton *item4Btn = [[UIButton alloc] init]; {
            [item4Btn setBackgroundColor:YTRandomColor];
            [item4Btn.titleLabel setNumberOfLines:0];
            [item4Btn setTag:4];
            [item4Btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [item4Btn addTarget:self action:@selector(itemBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [containView addSubview:item4Btn];
        self.item4Btn = item4Btn;
        
        UILabel *explainsLabel = [[UILabel alloc] init]; {
            [explainsLabel setBackgroundColor:YTRandomColor];
            [explainsLabel setNumberOfLines:0];
        }
        [containView addSubview:explainsLabel];
        self.explainsLabel = explainsLabel;
    }
    
    [self.contentView addSubview:containView];
    self.containView = containView;
    return self;
}

- (void)setProblem:(YTProblem *)problem {
    
    _problem = problem;
    
    [self.questionLabel setText:problem.question];
    if (problem.url.length) {
        [self.urlImageView sd_setImageWithURL:[NSURL URLWithString:problem.url]];
    }
    if (problem.item3.length && problem.item4.length) {
        [self.item1Btn setTitle:[@"A. " stringByAppendingString:problem.item1] forState:UIControlStateNormal];
        [self.item2Btn setTitle:[@"B. " stringByAppendingString:problem.item2] forState:UIControlStateNormal];
        [self.item3Btn setTitle:[@"C. " stringByAppendingString:problem.item3] forState:UIControlStateNormal];
        [self.item4Btn setTitle:[@"D. " stringByAppendingString:problem.item4] forState:UIControlStateNormal];
    } else {
        [self.item1Btn setTitle:problem.item1 forState:UIControlStateNormal];
        [self.item2Btn setTitle:problem.item2 forState:UIControlStateNormal];
    }
    
    [self.explainsLabel setText:[@"解释：\n       " stringByAppendingString:problem.explains]];
    
   
    //校正位置
    CGFloat horizontalMargin = 10;//水平
    CGFloat verticalMargin = 10;//竖直
    CGFloat margin = 10;
    CGFloat width = self.width - 2*horizontalMargin;
    [self.questionLabel setFrame:({
        CGSize realSize = [self.questionLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
        CGRectMake(horizontalMargin, verticalMargin, width, realSize.height);
    })];
  
    UIView *lastAdjustView = self.questionLabel;
    if (problem.url.length) {
        [self.urlImageView setHidden:NO];
        [self.urlImageView setFrame:CGRectMake(self.questionLabel.x, self.questionLabel.bottomY + margin, width, width*0.5)];
        lastAdjustView = self.urlImageView;
    } else {
        [self.urlImageView setHidden:YES];
    }
   
    CGFloat itemH = 50;
    CGFloat itemMargin = 5;
    [self.item1Btn setFrame:CGRectMake(lastAdjustView.x, lastAdjustView.bottomY + margin, width, itemH)];
    [self.item2Btn setFrame:CGRectMake(self.item1Btn.x, self.item1Btn.bottomY + itemMargin, width, itemH)];
    
    lastAdjustView = self.item2Btn;
    if (problem.item3.length) {
        [self.item3Btn setHidden:NO];
        [self.item4Btn setHidden:NO];
        [self.item1Btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.item2Btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.item3Btn setFrame:CGRectMake(self.item2Btn.x, self.item2Btn.bottomY + itemMargin, width, itemH)];
        [self.item4Btn setFrame:CGRectMake(self.item3Btn.x, self.item3Btn.bottomY + itemMargin, width, itemH)];
        lastAdjustView = self.item4Btn;
    } else {
        [self.item3Btn setHidden:YES];
        [self.item4Btn setHidden:YES];
        [self.item1Btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.item2Btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    }
    
    switch (problem.completeState) {
        case YTProblemCompleteStateUnchoice: {
            [self.explainsLabel setHidden:YES];
            self.item1Btn.enabled = YES;
            self.item2Btn.enabled = YES;
            self.item3Btn.enabled = YES;
            self.item4Btn.enabled = YES;
            break;
        }
        case YTProblemCompleteStateChoiceSuccess: {
            self.item1Btn.enabled = NO;
            self.item2Btn.enabled = NO;
            self.item3Btn.enabled = NO;
            self.item4Btn.enabled = NO;
            break;
        }
        case YTProblemCompleteStateChoiceFailure: {
            [self.explainsLabel setHidden:NO];
            [self.explainsLabel setFrame:({
                CGSize realSize = [self.explainsLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
                CGRectMake(lastAdjustView.x, lastAdjustView.bottomY + margin, width, realSize.height);
            })];
            self.item1Btn.enabled = NO;
            self.item2Btn.enabled = NO;
            self.item3Btn.enabled = NO;
            self.item4Btn.enabled = NO;
            lastAdjustView = self.explainsLabel;
            break;
        }
    }
    [self.containView setContentSize:CGSizeMake(0, lastAdjustView.bottomY+margin)];
}

- (void)itemBtnDidClick:(UIButton *)itemBtn {
    
    if ([self.delegate respondsToSelector:@selector(problemCell:didSelectedProblem:answerOrder:)]) {
        [self.delegate problemCell:self didSelectedProblem:self.problem answerOrder:itemBtn.tag];
    }
    NSLog(@"%zi",itemBtn.tag);
}

@end
