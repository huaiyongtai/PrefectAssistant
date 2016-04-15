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

    
    [self.navigationItem setTitleView:({
        UILabel *titleView = [[UILabel alloc] init]; {
            [titleView setText:@"正在测试"];
            titleView.height = 44;
        }
        self.scoreView = titleView;
        titleView;
    })];
    
    [self setupUIConfig];
    
    [self driverQuestionFromNetwork];
}

- (void)setupUIConfig {

    [self.view setBackgroundColor:YTColorBackground];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                                          collectionViewLayout:({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setItemSize:CGSizeMake(YTSCREEN_W, YTSCREEN_H-64)];
        [flowLayout setMinimumLineSpacing:0];
        flowLayout;})]; {
        
        [collectionView registerClass:[YTProblemCell class] forCellWithReuseIdentifier:@"YTProblemCell"];
        [collectionView setBackgroundColor:YTColorBackground];
        [collectionView setPagingEnabled:YES];
        [collectionView setDelegate:self];
        [collectionView setDataSource:self];
    }
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.problems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YTProblem *problem = self.problems[indexPath.item];
    
    YTProblemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YTProblemCell" forIndexPath:indexPath];
    [cell setDelegate:self];
    [cell setProblem:problem];
    return cell;
}

- (void)driverQuestionFromNetwork {
    
    if (!self.parameters.count) return;
  
    [YTHTTPTool bdGet:APIDriverExamQ parameters:self.parameters autoShowLoading:YES success:^(id responseObject) {

        NSArray *resultArray = responseObject[@"result"];
        if (![resultArray isKindOfClass:[NSArray class]]) {
            [YTAlertView showAlertMsg:YTHTTPDataException];
            return;
        }
        if (resultArray.count == 0) {
            [YTAlertView showAlertMsg:YTHTTPDataZero];
            return;
        }
        self.problems = [YTProblem mj_objectArrayWithKeyValuesArray:resultArray];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [YTAlertView showAlertMsg:YTHTTPFailure];
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
