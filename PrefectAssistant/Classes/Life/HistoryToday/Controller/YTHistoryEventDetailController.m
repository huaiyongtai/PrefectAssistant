

//
//  YTHistoryEventDetailController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/7.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTHistoryEventDetailController.h"
#import "YTHistoryEvent.h"
#import "YTEventDetail.h"
#import "YTRoundView.h"

@interface YTHistoryEventDetailController ()

@property (nonatomic, strong) YTEventDetail *eventDetail;

@end

@implementation YTHistoryEventDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:YTColorBackground];
    
    [self.navigationItem setTitleView:({
        UILabel *titlelabel = [[UILabel alloc] init]; {
            [titlelabel setText:self.historyEvent.title];
            [titlelabel setFont:[UIFont systemFontOfSize:14]];
            [titlelabel setNumberOfLines:0];
            [titlelabel setTextAlignment:NSTextAlignmentCenter];
            [titlelabel setSize:CGSizeMake(100, 40)];
        }
        titlelabel;
    })];
   
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"e_id"] = self.historyEvent.eId;
    paramters[@"key"] = @"c5770adc04027151413c7b1437cccc8a";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:@"http://v.juhe.cn/todayOnhistory/queryDetail.php" parameters:paramters  progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.eventDetail = [YTEventDetail mj_objectWithKeyValues:responseObject[@"result"][0]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
}

- (void)setEventDetail:(YTEventDetail *)eventDetail {
    
    _eventDetail = eventDetail;
    UIScrollView *containView = [[UIScrollView alloc] init]; {
        [containView setFrame:CGRectMake(0, HNav, YTSCREEN_W, YTSCREEN_H-64)];
        [containView setBackgroundColor:YTColorBackground];
        [containView setShowsVerticalScrollIndicator:NO];
    }
    [self.view addSubview:containView];
    
    CGFloat margin = 10;
    
    YTRoundView *roundView = nil;
    if ([eventDetail.picNo integerValue]) {
        roundView = [YTRoundView roundViewWitAdImageInfos:[eventDetail.picUrl valueForKeyPath:@"url"]
                                                              adTitles:[eventDetail.picUrl valueForKeyPath:@"pic_title"]]; {
            [roundView setFrame:CGRectMake(0, 0, YTSCREEN_W, 180)];
        }
        [containView addSubview:roundView];
    }
    
    UILabel *contentView = [[UILabel alloc] init]; {
        [contentView setNumberOfLines:0];
        [contentView setFont:[UIFont systemFontOfSize:16]];
        [contentView setTextColor:YTColorGrayText];
        [contentView setText:eventDetail.content];
        [contentView setFrame:({
            CGFloat horMargin = 6;
            CGFloat contentW = YTSCREEN_W - 2*horMargin;
            CGFloat contentH = [contentView sizeThatFits:CGSizeMake(contentW, CGFLOAT_MAX)].height;
            CGRectMake(horMargin, roundView.bottomY+margin, contentW, contentH);
        })];
    }
    [containView addSubview:contentView];
    [containView setContentSize:CGSizeMake(0, contentView.bottomY)];
}

@end
