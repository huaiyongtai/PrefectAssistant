//
//  YTCookBookController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/22.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTCookBookController.h"
#import "YTHTTPTool.h"
#import <AFNetworking.h>
#import "YTCookKindView.h"
#import "YTCookKindItem.h"
#import "YTCookListController.h"
#import "YTSearchBar.h"
#import "YTDish.h"


@interface YTCookBookController () <UITextFieldDelegate>

@property (nonatomic, weak) YTCookKindView *kindView;

@end

@implementation YTCookBookController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"菜谱"];
    
    [self setupUIConfig];
    
    [self loadCookSortInfoFromNetwork];
}

- (void)setupUIConfig {
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, YTSCREEN_W, 200)]; {
        
        YTSearchBar*searchBar = [YTSearchBar searchBar]; {
            [searchBar setPlaceholder:@"快速搜索"];
            [searchBar setFrame:CGRectMake(0, 0, YTSCREEN_W, 35)];
            [searchBar setDelegate:self];
            [searchBar setReturnKeyType:UIReturnKeySearch];
        }
        [headerView addSubview:searchBar];
        
        YTCookKindView *kindView = [[YTCookKindView alloc] init]; {
            kindView.cols = 5;
            kindView.kindItemBlock = ^(YTCookKindItem *kindItem) {
                YTCookListController *listVC = [YTCookListController cookListVCWithKindItem:kindItem];
                [self.navigationController pushViewController:listVC animated:YES];
            };
            [kindView setFrame:CGRectMake(0, searchBar.bottomY, YTSCREEN_W, headerView.height-searchBar.bottomY)];
        }
        [headerView addSubview:kindView];
        self.kindView = kindView;
    }
    
    YTCookListController *cookListVC = [[YTCookListController alloc] init];
    cookListVC.showSectionName = YES;
    [self addChildViewController:cookListVC];
    UITableView *cookListView = cookListVC.tableView; {
        [cookListView setFrame:CGRectMake(0, 64, YTSCREEN_W, YTSCREEN_H-64)];
        [cookListView setTableHeaderView:headerView];
    }
    [self.view addSubview:cookListView];
    
}
- (void)loadCookSortInfoFromNetwork {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer setValue:APIKEY forHTTPHeaderField:@"apikey"];

    [mgr GET:@"http://apis.baidu.com/tngou/cook/classify" parameters:nil  progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *cookKinds = [YTCookKindItem mj_objectArrayWithKeyValuesArray:responseObject[@"tngou"]];
        self.kindView.kindItems = cookKinds;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    NSString *cookName = textField.text;
    if (!cookName.length) return YES;
    
    NSDictionary *parameters = @{@"name" : cookName};
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer setValue:APIKEY forHTTPHeaderField:@"apikey"];
    [mgr GET:@"http://apis.baidu.com/tngou/cook/name" parameters:parameters  progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *dishes = [YTDish mj_objectArrayWithKeyValuesArray:responseObject[@"tngou"]];
        if (dishes.count == 0) {
            [YTAlertView showAlertMsg:[NSString stringWithFormat:@"未找到 %@ 菜品", cookName]];
            return;
        }
        textField.text = nil;
        YTCookListController *cookListVC = [YTCookListController cookListVCWithDishes:dishes]; {
            cookListVC.titleName = cookName;
        }
        [self.navigationController pushViewController:cookListVC animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];

    return YES;
}


@end
