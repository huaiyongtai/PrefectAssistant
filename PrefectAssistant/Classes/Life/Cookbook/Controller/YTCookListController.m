//
//  YTCookListController.m
//  
//
//  Created by HelloWorld on 16/3/24.
//
//

#import "YTCookListController.h"
#import "YTHTTPTool.h"
#import <AFNetworking.h>
#import "YTCookKindView.h"
#import "YTCookKindItem.h"
#import "YTDish.h"
#import "YTDishCell.h"
#import <MJRefresh.h>
#import "YTCookDetailController.h"

@interface YTCookListController ()

@property (nonatomic, strong) NSMutableArray<YTDish *> *dishes;
@property (nonatomic, assign, getter=isLocalDishes) BOOL localDishes;

@end

@implementation YTCookListController

+ (instancetype)cookListVCWithDishes:(NSMutableArray<YTDish *> *)dishes {

    YTCookListController *listVC = [[self alloc] init];
    listVC.dishes = dishes;
    listVC.localDishes = YES;
    return listVC;

}

+ (instancetype)cookListVCWithKindItem:(YTCookKindItem *)kindItem {
    
    YTCookListController *listVC = [[self alloc] init];
    listVC.kindItem = kindItem;
    listVC.titleName = kindItem.name;
    
    return listVC;
}

- (instancetype)init {
    
    self = [super init];
    if (self == nil) return nil;
    
    _showSectionName = NO;
    _localDishes = NO;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleName;
    
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    if (self.isLocalDishes) {
        [self.tableView reloadData];
        return;
    }
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadCookListInfoFromNetworkIsHeaderRefresh:YES];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadCookListInfoFromNetworkIsHeaderRefresh:NO];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadCookListInfoFromNetworkIsHeaderRefresh:(BOOL)headerRefresh {
    
    static NSInteger page = 1;
    if (headerRefresh) {
        page = 1;
    }
    
    NSDictionary *parameters = @{@"id" : self.kindItem.idStr ? : @"0",
                                 @"page" : [NSString stringWithFormat:@"%zi", page+1],
                                 @"rows" : @"20"};
    [YTHTTPTool bdGet:APICookListQ parameters:parameters success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
       
        NSArray *resultArray = responseObject[@"tngou"];
        if (![resultArray isKindOfClass:[NSArray class]]) {
            [YTAlertView showAlertMsg:YTHTTPDataException];
            return;
        }
        if (resultArray.count == 0) {
            [YTAlertView showAlertMsg:YTHTTPDataZero];
            return;
        }
        if (headerRefresh) {
            self.dishes = [YTDish mj_objectArrayWithKeyValuesArray:resultArray];
        } else {
            [self.dishes addObjectsFromArray:[YTDish mj_objectArrayWithKeyValuesArray:resultArray]];
            page++;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [YTAlertView showAlertMsg:YTHTTPFailure];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dishes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTDishCell *cell = [YTDishCell dishCellWithTableView:tableView];
    cell.dish = self.dishes[indexPath.row];
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YTCookDetailController *cookDetailVC = [YTCookDetailController cookDetailVCWithDish:self.dishes[indexPath.row]];
    [self.navigationController pushViewController:cookDetailVC animated:YES];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.isShowSectionName) {
        return @"菜品列表";
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YTDishHeight;
}

@end
