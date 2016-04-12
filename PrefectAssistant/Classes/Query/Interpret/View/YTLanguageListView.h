//
//  YTLanguageListView.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/30.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTLanguageCode;

@interface YTLanguageListView : UITableView

@property (nonatomic, strong) NSArray <YTLanguageCode *> *languages;

@end
