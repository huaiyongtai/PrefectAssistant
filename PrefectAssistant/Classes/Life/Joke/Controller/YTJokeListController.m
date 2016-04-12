//
//  YTJokeListController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/6.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTJokeListController.h"
#import <HMSegmentedControl.h>
#import "YTJoke.h"
#import "YTJokeCell.h"
#import <MJRefresh.h>

typedef NS_ENUM(NSUInteger, YTJokeTypes) {
    YTJokeTypeTextJoke,
    YTJokeTypeImgJoke,
};

@interface YTJokeListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) YTJokeTypes jokeType;

@property (nonatomic, assign) NSInteger textJokePage;
@property (nonatomic, assign) NSInteger imgJokePage;

@property (nonatomic, strong) NSMutableArray *jokes;
@property (nonatomic, strong) NSMutableArray *tempJokes;


@end

@implementation YTJokeListController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view setBackgroundColor:YTRandomColor];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.jokes = [NSMutableArray array];
    self.tempJokes = [NSMutableArray array];
   
    [self setupUIConfig];
}

- (void)setupUIConfig {
   
    CGFloat margin = 10;
    HMSegmentedControl *segementControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"文字模式", @"图片模式"]]; {
        [segementControl setFrame:CGRectMake(-1, 64+margin, YTSCREEN_W+2, 40)];
        [segementControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
        [segementControl setIndexChangeBlock:^(NSInteger index) {
            if (index == 0) {
                self.jokeType = YTJokeTypeTextJoke;
            } else {
                self.jokeType = YTJokeTypeImgJoke;
                if (self.tempJokes.count==0) {
                    [self.tableView.mj_header beginRefreshing];
                }
            }
            NSMutableArray *tempArray = self.jokes;
            self.jokes = self.tempJokes;
            self.tempJokes = tempArray;
            [self.tableView reloadData];
        }];
    }
    [self.view addSubview:segementControl];
    
    CGFloat tableViewH = YTSCREEN_H - segementControl.bottomY + margin;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, segementControl.bottomY + margin, YTSCREEN_W, tableViewH) style:UITableViewStylePlain]; {
        [tableView setBackgroundColor:YTRandomColor];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [tableView setTableFooterView:[[UIView alloc] init]];
        
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            switch (self.jokeType) {
                case YTJokeTypeTextJoke: {
                    self.textJokePage = 0;
                    break;
                }
                case YTJokeTypeImgJoke: {
                    self.imgJokePage = 0;
                    break;
                }
            }
            [self loadJokesFromNetworkWithRefreshingHeader:YES];
        }];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            switch (self.jokeType) {
                case YTJokeTypeTextJoke: {
                    self.textJokePage++;
                    break;
                }
                case YTJokeTypeImgJoke: {
                    self.imgJokePage++;
                    break;
                }
            }
            [self loadJokesFromNetworkWithRefreshingHeader:NO];
        }];
        [tableView.mj_header beginRefreshing];
    }
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)loadJokesFromNetworkWithRefreshingHeader:(BOOL)isRefreshingHeader {

    NSString *page = nil;
    NSString *urlString = nil;
    switch (self.jokeType) {
        case YTJokeTypeTextJoke: {
            urlString = @"http://japi.juhe.cn/joke/content/text.from";
            page = [NSString stringWithFormat:@"%zi", (++self.textJokePage)];
            break;
        }
        case YTJokeTypeImgJoke: {
            urlString = @"http://japi.juhe.cn/joke/img/text.from";
            page = [NSString stringWithFormat:@"%zi", (++self.imgJokePage)];
            break;
        }
    }
    
    NSDictionary *parameters = @{@"key"     : @"3c08a985114fc4c68aed3ca693cc9da1",
                                 @"page"    : page,
                                 @"pagesize": @"20"};
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:urlString parameters:parameters  progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
        
         NSMutableArray *pageJokes = [YTJoke mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
         if (isRefreshingHeader) {
             self.jokes = pageJokes;
         } else {
             [self.jokes addObjectsFromArray:pageJokes];
         }
         [self.tableView reloadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self.tableView.mj_header endRefreshing];
         NSLog(@"error:%@", error);
     }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.jokes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTJoke *joke = self.jokes[indexPath.row];
    YTJokeCell *cell = [YTJokeCell jokeCellWithTableView:tableView];
    cell.joke = joke;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    YTJoke *joke = self.jokes[indexPath.row];
    return joke.totalHeight;
}
@end
