//
//  YTProblemCell.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/1.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTProblem, YTProblemCell;

@protocol YTProblemCellDelegate <NSObject>

@optional
- (void)problemCell:(YTProblemCell *)cell didSelectedProblem:(YTProblem *)problem answerOrder:(NSUInteger)answerOrder;

@end

@interface YTProblemCell : UICollectionViewCell

@property (nonatomic, weak) id<YTProblemCellDelegate>delegate;
@property (nonatomic, strong) YTProblem *problem;

@end
