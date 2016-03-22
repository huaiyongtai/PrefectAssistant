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
                                                            itemTitles:@[@"菜谱", @"视频", @"说客", @"电台"]
                                                            themeColor:YTRandomColor
                                                  catalogSelectedBlock:^(NSString *title) {
                                                      NSLog(@"点击了%@", title);
                                                  } itemSelectedBlock:^(NSInteger index, NSString *title) {
                                                      NSLog(@"点击了第 %li 个 名字为：%@ 的按钮", (long)index, title);
                                                  }];
    [lifeView setFrame:CGRectMake(0, roundView.bottomY, YTSCREEN_W, 100)];
    [containView addSubview:lifeView];
    
    YTModuleView *moduleView1 = [YTModuleView moduleVieWithCatalogTitle:@"娱乐"
                                                             itemTitles:@[@"快报", @"视频", @"说客", @"电台"]
                                                             themeColor:YTRandomColor
                                                   catalogSelectedBlock:^(NSString *title) {
                                                       NSLog(@"点击了%@", title);
                                                   } itemSelectedBlock:^(NSInteger index, NSString *title) {
                                                       NSLog(@"点击了第 %li 个 名字为：%@ 的按钮", (long)index, title);
                                                   }];
    [moduleView1 setFrame:CGRectMake(0, lifeView.bottomY, YTSCREEN_W, 100)];
    [containView addSubview:moduleView1];
    
    YTModuleView *moduleView2 = [YTModuleView moduleVieWithCatalogTitle:@"查询"
                                                             itemTitles:@[@"快报", @"视频", @"说客", @"电台"]
                                                             themeColor:YTRandomColor
                                                   catalogSelectedBlock:^(NSString *title) {
                                                       NSLog(@"点击了%@", title);
                                                   } itemSelectedBlock:^(NSInteger index, NSString *title) {
                                                       NSLog(@"点击了第 %li 个 名字为：%@ 的按钮", (long)index, title);
                                                   }];
    [moduleView2 setFrame:CGRectMake(0, moduleView1.bottomY, YTSCREEN_W, 100)];
    [containView addSubview:moduleView2];
    
    YTModuleView *moduleView3 = [YTModuleView moduleVieWithCatalogTitle:@"搞笑"
                                                             itemTitles:@[@"快报", @"视频", @"说客", @"电台"]
                                                             themeColor:YTRandomColor
                                                   catalogSelectedBlock:^(NSString *title) {
                                                       NSLog(@"点击了%@", title);
                                                   } itemSelectedBlock:^(NSInteger index, NSString *title) {
                                                       NSLog(@"点击了第 %li 个 名字为：%@ 的按钮", (long)index, title);
                                                   }];
    [moduleView3 setFrame:CGRectMake(0, moduleView2.bottomY, YTSCREEN_W, 100)];
    [containView addSubview:moduleView3];
    
    [containView setContentSize:CGSizeMake(0, moduleView3.bottomY)];
    [self.view addSubview:containView];
}

- (void)lifeViewDidSelectedItem:(NSInteger)itemIndex {
    
    
    
    
    
    
}


#pragma mark - Nav
- (void)rightNavDidClick {
    
}
- (void)leftNavDidClick {
    
}

@end
