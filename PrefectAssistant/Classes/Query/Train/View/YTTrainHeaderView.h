//
//  YTTrainHeaderView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/28.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat YTTrainHeaderViewH;

@class YTTrain, YTTrainHeaderView;

@protocol YTTrainHeaderViewDelegate <NSObject>

@optional
- (void)trainHeaderView:(YTTrainHeaderView *)headerView train:(YTTrain *)train didShowRevealseatInfos:(BOOL)isReveal;
- (void)trainHeaderView:(YTTrainHeaderView *)headerView didSelectedTrainNumber:(NSString *)trainNo;

@end

@interface YTTrainHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) YTTrain *train;

@property (nonatomic, weak) id<YTTrainHeaderViewDelegate> delegate;

+ (instancetype)trainHeaderViewWith:(UITableView *)tableView;

@end
