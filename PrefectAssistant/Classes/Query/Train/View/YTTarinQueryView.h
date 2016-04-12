//
//  YTTarinQueryView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/25.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTTarinQueryView, YTTrainInfoQuery;

@protocol YTTarinQueryViewDelegate <NSObject>

- (void)trarinQueryViewDidSelectedDepartedTime:(YTTarinQueryView *)queryView;

- (void)trarinQueryView:(YTTarinQueryView *)queryView didSelectedQuery:(YTTrainInfoQuery *)query;

@end

@interface YTTarinQueryView : UIView

@property (nonatomic, strong) YTTrainInfoQuery *query;
@property (nonatomic, weak) id<YTTarinQueryViewDelegate> delegate;

- (void)setQueryCalender:(NSString *)calenderStr week:(NSString *)weekStr;

@end
