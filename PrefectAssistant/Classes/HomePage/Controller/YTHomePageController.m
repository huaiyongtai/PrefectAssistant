//
//  YTHomePageController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/14.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTHomePageController.h"
#import "YTRoundView.h"
#import "YTModuleView.h"
#import "YTSettingController.h"
#import "WZWeatherViewController.h"


#import "YTCookBookController.h"        //菜谱
#import "YTTVCategoryController.h"      //电视
#import "YTJokeListController.h"        //笑话
#import "YTHistoryQueryController.h"    //历时

#import "YTDriverSubjectController.h"   //驾考
#import "YTPostCodeQueryController.h"   //邮编
#import "YTInterpretController.h"       //翻译
#import "YTDreamQueryController.h"      //解梦

#import "YTBusQueryController.h"        //公交
#import "YTExpressageController.h"      //快递
#import "YTTrainInfoQueryController.h"  //火车

@interface YTHomePageController ()

@end

@implementation YTHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view setBackgroundColor:YTRandomColor];
    
    self.title = @"百分助理";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rightNavDidClick)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"天气"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(leftNavDidClick)];
    
    [self setupViews];
}

- (void)setupViews {
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    UIScrollView *containView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    YTRoundView *roundView = [YTRoundView roundViewWitAdImageInfos:@[@"domeImage0", @"domeImage1.jpg", @"domeImage2.jpg", @"domeImage3.jpg"]
                                                          adTitles:nil didSelected:^(NSInteger index, id adInfo) {
                                                              NSLog(@"您选择了第 %li 张图片", index);
                                                          }];
    [roundView setShowPageIndicator:YES];
    [roundView setFrame:CGRectMake(0, 64, YTSCREEN_W, 150)];
    [containView addSubview:roundView];
    
    YTModuleView *lifeView = [YTModuleView moduleVieWithCatalogTitle:@"生活"
                                                            itemTitles:@[@"菜谱", @"电视", @"笑话", @"历时"]
                                                            themeColor:YTRandomColor
                                                  catalogSelectedBlock:^(NSString *title) {
                                                      NSLog(@"点击了%@", title);
                                                  } itemSelectedBlock:^(NSInteger index, NSString *title) {
                                                      switch (index) {
                                                          case 0:
                                                              [self.navigationController pushViewController:[[YTCookBookController alloc] init]
                                                                                                   animated:YES];
                                                              break;
                                                          case 1:
                                                              [self.navigationController pushViewController:[[YTTVCategoryController alloc] init]
                                                                                                   animated:YES];
                                                              break;
                                                          case 2:
                                                              [self.navigationController pushViewController:[[YTJokeListController alloc] init]
                                                                                                   animated:YES];
                                                              break;
                                                          case 3:
                                                              [self.navigationController pushViewController:[[YTHistoryQueryController alloc] init]
                                                                                                   animated:YES];
                                                              break;
                                                      }
                                                  }];
    [lifeView setFrame:CGRectMake(0, roundView.bottomY, YTSCREEN_W, 100)];
    [containView addSubview:lifeView];
    
    YTModuleView *queryView = [YTModuleView moduleVieWithCatalogTitle:@"娱乐"
                                                             itemTitles:@[@"驾考", @"邮编", @"翻译", @"解梦"]
                                                             themeColor:YTRandomColor
                                                   catalogSelectedBlock:^(NSString *title) {
                                                       NSLog(@"点击了%@", title);
                                                   } itemSelectedBlock:^(NSInteger index, NSString *title) {
                                                       switch (index) {
                                                           case 0:
                                                               [self.navigationController pushViewController:[[YTDriverSubjectController alloc] init]
                                                                                                    animated:YES];
                                                               break;
                                                           case 1:
                                                               [self.navigationController pushViewController:[[YTPostCodeQueryController alloc] init]
                                                                                                    animated:YES];
                                                               break;
                                                           case 2:
                                                               [self.navigationController pushViewController:[[YTInterpretController alloc] init]
                                                                                                    animated:YES];
                                                               break;
                                                           case 3:
                                                               [self.navigationController pushViewController:[[YTDreamQueryController alloc] init]
                                                                                                    animated:YES];
                                                               break;
                                                       }
                                                       NSLog(@"点击了第 %li 个 名字为：%@ 的按钮", (long)index, title);
                                                   }];
    [queryView setFrame:CGRectMake(0, lifeView.bottomY, YTSCREEN_W, 100)];
    [containView addSubview:queryView];
    
    YTModuleView *moduleView2 = [YTModuleView moduleVieWithCatalogTitle:@"查询"
                                                             itemTitles:@[@"公交", @"快递", @"火车", @"天气"]
                                                             themeColor:YTRandomColor
                                                   catalogSelectedBlock:^(NSString *title) {
                                                       NSLog(@"点击了%@", title);
                                                   } itemSelectedBlock:^(NSInteger index, NSString *title) {
                                                       switch (index) {
                                                           case 0:
                                                               [self.navigationController pushViewController:[[YTBusQueryController alloc] init]
                                                                                                    animated:YES];
                                                               break;
                                                           case 1:
                                                               [self.navigationController pushViewController:[[YTExpressageController alloc] init]
                                                                                                    animated:YES];
                                                               break;
                                                           case 2:
                                                               [self.navigationController pushViewController:[[YTTrainInfoQueryController alloc] init]
                                                                                                    animated:YES];
                                                               break;
                                                           case 3:
                                                               [self rightNavDidClick];
                                                               break;
                                                       }
                                                   }];
    [moduleView2 setFrame:CGRectMake(0, queryView.bottomY, YTSCREEN_W, 100)];
    [containView addSubview:moduleView2];
    
    [containView setContentSize:CGSizeMake(0, moduleView2.bottomY)];
    [self.view addSubview:containView];
}

#pragma mark - Nav
- (void)rightNavDidClick {
    
    YTSettingController *settingVC = [[YTSettingController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

- (void)leftNavDidClick {
    WZWeatherViewController *weatherVC = [[WZWeatherViewController alloc] init];
    [self presentViewController:weatherVC animated:YES completion:nil];
}

@end
