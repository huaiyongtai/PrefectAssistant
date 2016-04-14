//
//  YTDriverSubjectController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/31.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTDriverSubjectController.h"
#import "YTDriverExamController.h"

@interface YTDriverSubjectController ()

@property (nonatomic, weak) UIButton *subjectBtn;
@property (nonatomic, weak) UIButton *modelTypeBtn;
@property (nonatomic, weak) UIButton *examTypeBtn;

@end

@implementation YTDriverSubjectController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"驾考测试";
    
    [self.view setBackgroundColor:YTColorBackground];
    
    CGFloat topMargin = HMargin;
    
    UIView *subjectView = [self setupRadioViewWithRadioNames:@[@"科目1", @"科目4"]
                                                      action:@selector(subjectBtnDidClick:)]; {
        [subjectView setOrigin:CGPointMake(-1, HNav + topMargin)];
    }
    [self.view addSubview:subjectView];
    
    UIView *modelTypeView = [self setupRadioViewWithRadioNames:@[@"C1", @"C2", @"B1", @"B2", @"A1", @"A2"]
                                                        action:@selector(modelTypeBtnDidClick:)]; {
        [modelTypeView setOrigin:CGPointMake(-1, subjectView.bottomY + topMargin)];
    }
    [self.view addSubview:modelTypeView];
    
    UIView *examTypeView = [self setupRadioViewWithRadioNames:@[@"测试模式", @"训练模式"]
                                                       action:@selector(examTypeBtnDidClick:)]; {
        [examTypeView setOrigin:CGPointMake(-1, modelTypeView.bottomY + topMargin)];
    }
    [self.view addSubview:examTypeView];
    
    UIButton *startExamBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
        CGFloat margin = 20;
        [startExamBtn setBackgroundColor:YTColorQueryButton];
        [startExamBtn setFrame:CGRectMake(20, examTypeView.bottomY + HMargin, (YTSCREEN_W-2*margin), 40)];
        [startExamBtn setTitle:@"开始测试" forState:UIControlStateNormal];
        [startExamBtn.layer setMasksToBounds:YES];
        [startExamBtn.layer setCornerRadius:5];
        [startExamBtn addTarget:self action:@selector(startExamDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:startExamBtn];

}
- (UIView *)setupRadioViewWithRadioNames:(NSArray *)radioNames action:(SEL)action {
    
    UIView *radioView = [[UIView alloc] init]; {
        CGFloat margin = 34;
        CGFloat padding = 9;
        NSInteger colCount = 2;
        CGFloat height = 40;
        CGFloat width = (YTSCREEN_W - 2*margin) * 0.5;
        for (NSUInteger index = 0; index<radioNames.count; index++) {
            UIButton *radioBtn = [UIButton buttonWithType:UIButtonTypeCustom]; {
                [radioBtn setTag:index];
                [radioBtn setTitle:radioNames[index] forState:UIControlStateNormal];
                [radioBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                [radioBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [radioBtn setImage:[UIImage imageNamed:@"btn_more_choice_nor"] forState:UIControlStateNormal];
                [radioBtn setImage:[UIImage imageNamed:@"btn_more_choice_pre"] forState:UIControlStateSelected];
                [radioBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, padding, 0, 0)];
                [radioBtn setFrame:CGRectMake(margin + width*(index%colCount), (index/2)*height, width, height)];
                [radioBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
                [radioView addSubview:radioBtn];
            }
            if (index == 0) {   //模拟一次点击
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self performSelector:action withObject:radioBtn];
            }
        }
        NSInteger rowCount = radioNames.count/colCount + radioNames.count%colCount;
        CGFloat radioViewHeight = rowCount * height;
        [radioView setBackgroundColor:[UIColor whiteColor]];
        [radioView setFrame:CGRectMake(0, 0, YTSCREEN_W+2, radioViewHeight)];
        [radioView.layer setBorderColor:YTColorLineSeparate];
        [radioView.layer setBorderWidth:HLineSeparate];
    }
    
    return radioView;
}
- (void)subjectBtnDidClick:(UIButton *)radioBtn {
    
    self.subjectBtn.selected = NO;
    radioBtn.selected = YES;
    self.subjectBtn = radioBtn;
}

- (void)modelTypeBtnDidClick:(UIButton *)radioBtn {
    
    self.modelTypeBtn.selected = NO;
    radioBtn.selected = YES;
    self.modelTypeBtn = radioBtn;
}

- (void)examTypeBtnDidClick:(UIButton *)radioBtn {
    
    self.examTypeBtn.selected = NO;
    radioBtn.selected = YES;
    self.examTypeBtn = radioBtn;
}

- (void)startExamDidClick {
//    subject
//    选择考试科目类型，1：科目1；4：科目4;其它取值默认是科目1
//
//    1
//    model
//    驾照类型，可选择参数为：c1,c2,a1,a2,b1,b2；当subject=4时可省略
//
//    c1
//    testType
//    测试类型，rand：随机测试（随机100个题目），order：顺序测试（所选科目全部题目）;其它取值默认是ranid
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    switch (self.subjectBtn.tag) {
        case 1:
            dict[@"subject"] = @"4";
            break;
        default:
            dict[@"subject"] = @"1";
            break;
    }
    
    switch (self.examTypeBtn.tag) {
        case 1:
            dict[@"testType"] = @"order";
            break;
        default :
            dict[@"testType"] = @"rand";
            break;
    }
    
    switch (self.modelTypeBtn.tag) {
        case 1:
            dict[@"model"] = @"c2";
            break;
        case 2:
            dict[@"model"] = @"b1";
            break;
        case 3:
            dict[@"model"] = @"b2";
            break;
        case 4:
            dict[@"model"] = @"a1";
            break;
        case 5:
            dict[@"model"] = @"a2";
            break;
        default:
            dict[@"model"] = @"c1";
            break;
    }
    
    YTDriverExamController *examVC = [[YTDriverExamController alloc] init];
    examVC.parameters = dict;
    [self.navigationController pushViewController:examVC animated:YES];
}
@end
