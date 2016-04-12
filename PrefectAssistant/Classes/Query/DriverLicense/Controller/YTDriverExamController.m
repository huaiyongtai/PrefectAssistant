//
//  YTDriverExamController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/1.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTDriverExamController.h"
#import "YTProblem.h"
#import "YTProblemCell.h"

@interface YTDriverExamController () <UICollectionViewDelegate, UICollectionViewDataSource, YTProblemCellDelegate>

@property (nonatomic, copy) NSArray<YTProblem *> *problems;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UILabel *scoreView;

@end

@implementation YTDriverExamController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:YTRandomColor];
    
    [self setupUIConfig];
    [self driverQuestionFromNetwork];

}

- (void)setupUIConfig {

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                                          collectionViewLayout:({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setItemSize:CGSizeMake(YTSCREEN_W, YTSCREEN_H-64)];
        [flowLayout setMinimumLineSpacing:0];
        flowLayout;})]; {
        
        [collectionView registerClass:[YTProblemCell class] forCellWithReuseIdentifier:@"YTProblemCell"];
        [collectionView setBackgroundColor:[UIColor redColor]];
        [collectionView setPagingEnabled:YES];
        [collectionView setDelegate:self];
        [collectionView setDataSource:self];
    }
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self.navigationItem setTitleView:({
        UILabel *titleView = [[UILabel alloc] init]; {
            [titleView setBackgroundColor:YTRandomColor];
            [titleView setText:@"adfasdfa"];
            titleView.height = 44;
        }
        self.scoreView = titleView;
        titleView;
    })];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.problems.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YTProblem *problem = self.problems[indexPath.item];
    
    YTProblemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YTProblemCell" forIndexPath:indexPath];
    [cell setDelegate:self];
    [cell setBackgroundColor:YTRandomColor];
    [cell setProblem:problem];
    return cell;
}

- (void)driverQuestionFromNetwork {
    
    if (!self.parameters.count) return;
   
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer setValue:APIKEY forHTTPHeaderField:@"apikey"];
    [mgr GET:@"http://apis.baidu.com/bbtapi/jztk/jztk_query" parameters:self.parameters
    progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.problems = [YTProblem mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self.collectionView reloadData];
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    
}

#pragma mark - YTProblemCellDelegate
- (void)problemCell:(YTProblemCell *)cell didSelectedProblem:(YTProblem *)problem answerOrder:(NSUInteger)answerOrder {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    BOOL completeReult = (answerOrder == problem.answer.integerValue);
    if (completeReult) {
        problem.completeState = YTProblemCompleteStateChoiceSuccess;
        if (indexPath.item+1 >= self.problems.count) {
            NSLog(@"已经做完题了");
        } else {
            NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:indexPath.item+1 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        }
    } else {
        problem.completeState = YTProblemCompleteStateChoiceFailure;
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        [self.collectionView setScrollEnabled:YES];
    }
}


@end
