//
//  YTDreamListController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/11.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTDreamListController.h"
#import "YTDream.h"
#import "YTDreamCell.h"

@interface YTDreamListController ()

@property (nonatomic, copy) NSArray *dreamRuslts;
@end

@implementation YTDreamListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = self.keyWord;
    
    [self.view setBackgroundColor:YTColorBackground];
    
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    
    [self loadDreamDataFromNetwork];
}

- (void)loadDreamDataFromNetwork {
    
    NSDictionary *parameters = @{@"key" : APIDreamKey,
                                 @"q"   : self.keyWord,
                                 @"full": @"1"};
    [YTHTTPTool get:APIDreamQ parameters:parameters autoShowLoading:YES success:^(id responseObject) {
        
        NSArray *resultArray = responseObject[@"result"];
        if (![resultArray isKindOfClass:[NSArray class]]) {
            [YTAlertView showAlertMsg:YTHTTPDataException];
            return;
        }
        if (resultArray.count == 0) {
            [YTAlertView showAlertMsg:YTHTTPDataZero];
            return;
        }
        self.dreamRuslts = [YTDream mj_objectArrayWithKeyValuesArray:resultArray];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [YTAlertView showAlertMsg:YTHTTPFailure];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dreamRuslts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTDream *dream = self.dreamRuslts[indexPath.row];
    YTDreamCell *cell = [YTDreamCell dreamCellWithTableView:tableView];
    cell.dream = dream;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    YTDream *dream = self.dreamRuslts[indexPath.row];
    return dream.totalHeight;
}

@end
