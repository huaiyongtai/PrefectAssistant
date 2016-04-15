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
   
    [YTHTTPTool bdGet:APICookClassifyQ parameters:nil success:^(id responseObject) {
        NSArray *resultArray = responseObject[@"tngou"];
        if (![resultArray isKindOfClass:[NSArray class]]) {
            [YTAlertView showAlertMsg:YTHTTPDataException];
            return;
        }
        if (resultArray.count == 0) {
            [YTAlertView showAlertMsg:YTHTTPDataZero];
            return;
        }
        NSMutableArray *cookKinds = [YTCookKindItem mj_objectArrayWithKeyValuesArray:resultArray];
        self.kindView.kindItems = cookKinds;
    } failure:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    NSString *cookName = textField.text;
    if (!cookName.length) return YES;
    
    NSDictionary *parameters = @{@"name" : cookName};
    [YTHTTPTool bdGet:APICookNameQ parameters:parameters autoShowLoading:YES success:^(id responseObject) {
      
        NSArray *resultArray = responseObject[@"tngou"];
        if (![resultArray isKindOfClass:[NSArray class]]) {
            [YTAlertView showAlertMsg:YTHTTPDataException];
            return;
        }
        if (resultArray.count == 0) {
            [YTAlertView showAlertMsg:YTHTTPDataZero];
            return;
        }
        NSMutableArray *dishes = [YTDish mj_objectArrayWithKeyValuesArray:resultArray];
        textField.text = nil;
        YTCookListController *cookListVC = [YTCookListController cookListVCWithDishes:dishes]; {
            cookListVC.titleName = cookName;
        }
        [self.navigationController pushViewController:cookListVC animated:YES];
    } failure:nil];

    return YES;
}


@end
