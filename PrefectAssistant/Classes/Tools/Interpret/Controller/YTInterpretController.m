//
//  YTInterpretController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/30.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTInterpretController.h"
#import "YTChoiceLanguageBtn.h"
#import "YTDropDownMenu.h"
#import "YTLanguageCode.h"

typedef NS_ENUM(NSUInteger, YTShowMenuFromViewTypes) {
    YTShowMenuFromViewTypeOrigin,
    YTShowMenuFromViewTypeDestination,
};

static const CGFloat YTTextViewMinH = 70;

@interface YTInterpretController () <YTDropDownMenuDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, weak) UIScrollView *containView;
@property (nonatomic, weak) YTChoiceLanguageBtn *originBtn;
@property (nonatomic, weak) YTChoiceLanguageBtn *destinationBtn;

@property (nonatomic, copy) NSArray <YTLanguageCode *> *languages;
@property (nonatomic, assign) YTShowMenuFromViewTypes showType;
@property (nonatomic, strong) YTDropDownMenu *languageMenu;

@property (nonatomic, weak) UIButton *convertBtn;
@property (nonatomic, weak) UILabel *resultLabel;
@property (nonatomic, weak) UITextView *originTextView;

@end

@implementation YTInterpretController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"翻译";
    
    [self setupUIConfig];
}
- (void)setupUIConfig {
    
    [self.view setBackgroundColor:YTColorBackground]
    ;
    UIScrollView *containView = [[UIScrollView alloc] init]; {
        [containView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        [containView setFrame:CGRectMake(0, 0, YTSCREEN_W, YTSCREEN_H)];
        
        CGFloat topMargin = 10;
        CGFloat margin = 15;
        
        CGFloat choiceLanguageW = (containView.width-2*margin) / 3;
        CGFloat choiceLanguageH = 35;
        YTChoiceLanguageBtn *originBtn = [[YTChoiceLanguageBtn alloc] init]; {
            [originBtn setLanguage:[YTLanguageCode languageCodeWithName:@"中文" code:@"zh"]];
            [originBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
            [originBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
            [originBtn setFrame:CGRectMake(margin, topMargin, choiceLanguageW, choiceLanguageH)];
            [originBtn addTarget:self action:@selector(choiceLanguage:) forControlEvents:UIControlEventTouchUpInside];
        }
        [containView addSubview:originBtn];
        self.originBtn = originBtn;
        
        UIButton *exchengeBtn = [[UIButton alloc] init]; {
            [exchengeBtn setImage:[UIImage imageNamed:@"exchange"] forState:UIControlStateNormal];
            [exchengeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [exchengeBtn setFrame:CGRectMake(originBtn.rightX, originBtn.y, choiceLanguageW, choiceLanguageH)];
            [exchengeBtn addTarget:self action:@selector(exchangeChoiceConetent) forControlEvents:UIControlEventTouchUpInside];
        }
        [containView addSubview:exchengeBtn];
        
        YTChoiceLanguageBtn *destinationBtn = [[YTChoiceLanguageBtn alloc] init]; {
            [destinationBtn setLanguage:[YTLanguageCode languageCodeWithName:@"英语" code:@"en"]];
            [destinationBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
            [destinationBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
            [destinationBtn setFrame:CGRectMake(exchengeBtn.rightX, exchengeBtn.y, choiceLanguageW, choiceLanguageH)];
            [destinationBtn addTarget:self action:@selector(choiceLanguage:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [containView addSubview:destinationBtn];
        self.destinationBtn =  destinationBtn;
        
        //原始内容
        CGFloat textViewOptionW = 40;
        CGFloat textViewOptionH = 20;
        UITextView *originTextView = [[UITextView alloc] init]; {
            [originTextView setFrame:CGRectMake(-1, destinationBtn.bottomY + topMargin, YTSCREEN_W+2, YTTextViewMinH)];
            [originTextView setTextContainerInset:UIEdgeInsetsMake(10, 0, 0, textViewOptionW)];
            [originTextView setFont:[UIFont systemFontOfSize:16]];
            [originTextView setShowsVerticalScrollIndicator:NO];
            [originTextView setKeyboardType:UIKeyboardTypeDefault];
            [originTextView setReturnKeyType:UIReturnKeyDone];
            [originTextView setDelegate:self];
            [originTextView.layer setBorderWidth:0.5];
            [originTextView.layer setBorderColor:YTColorLineSeparate];
        }
        [containView addSubview:originTextView];
        self.originTextView = originTextView;
        
        UIButton *clearBtn = [[UIButton alloc] init]; {
            [clearBtn setBackgroundColor:YTRandomColor];
            [clearBtn setTitle:@"清除" forState:UIControlStateNormal];
            [clearBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [clearBtn setFrame:CGRectMake(originTextView.width-textViewOptionW, originTextView.y+10, textViewOptionW, textViewOptionH)];
            [clearBtn addTarget:self action:@selector(clearOriginText) forControlEvents:UIControlEventTouchUpInside];
        }
        [containView addSubview:clearBtn];
        UIButton *convertBtn = [[UIButton alloc] init]; {
            [convertBtn setBackgroundColor:YTColorQueryButton];
            [convertBtn setTitle:@"翻译" forState:UIControlStateNormal];
            [convertBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [convertBtn setFrame:CGRectMake(clearBtn.x, originTextView.bottomY-textViewOptionH-topMargin, textViewOptionW, textViewOptionH)];
            [convertBtn addTarget:self action:@selector(convertOriginTextToResultText) forControlEvents:UIControlEventTouchUpInside];
        }
        [containView addSubview:convertBtn];
        self.convertBtn = convertBtn;
        
        //翻译结果
        UILabel *resultLabel = [[UILabel alloc] init]; {
            [resultLabel setNumberOfLines:0];
            [resultLabel setOrigin:CGPointMake(-1, originTextView.bottomY + topMargin)];
            [resultLabel setBackgroundColor:[UIColor whiteColor]];
            [resultLabel.layer setBorderWidth:HLineSeparate];
            [resultLabel.layer setBorderColor:YTColorLineSeparate];
        }
        [containView addSubview:resultLabel];
        self.resultLabel = resultLabel;
    }
    [self.view addSubview:containView];
    self.containView = containView;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    if (YTTextViewMinH > textView.contentSize.height) return;
    
    [textView setSize:textView.contentSize];
    [self.convertBtn setY:(textView.bottomY - self.convertBtn.height - 10)];
    [self.resultLabel setY:textView.bottomY + 10];
    [self.containView setContentSize:CGSizeMake(YTSCREEN_W, self.resultLabel.bottomY)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self convertOriginTextToResultText];
        return NO;
    }
    return YES;
}

- (NSArray<YTLanguageCode *> *)languages {

    if (_languages == nil) {
        NSArray *languageArray = @[@{@"code" : @"zh",   @"name" : @"中文"},
                                   @{@"code" : @"en",   @"name" : @"英语"},
                                   @{@"code" : @"jp",   @"name" : @"日语"},
                                   @{@"code" : @"kor",  @"name" : @"韩语"},
                                   @{@"code" : @"spa",  @"name" : @"班牙语"},
                                   @{@"code" : @"fra",  @"name" : @"法语"},
                                   @{@"code" : @"th",   @"name" : @"泰语"},
                                   @{@"code" : @"ara",  @"name" : @"阿拉伯语"},
                                   @{@"code" : @"ru",   @"name" : @"俄罗斯语"},
                                   @{@"code" : @"pt",   @"name" : @"葡萄牙语"},
                                   @{@"code" : @"yue",  @"name" : @"粤语"},
                                   @{@"code" : @"wyw",  @"name" : @"文言文"},
                                   @{@"code" : @"zh",   @"name" : @"白话文"},
                                   @{@"code" : @"auto", @"name" : @"自动检测"},
                                   @{@"code" : @"de",   @"name" : @"德语"},
                                   @{@"code" : @"it",   @"name" : @"意大利语"},
                                   @{@"code" : @"nl",   @"name" : @"荷兰语"},
                                   @{@"code" : @"el",   @"name" : @"希腊语"}];
        _languages = [YTLanguageCode mj_objectArrayWithKeyValuesArray:languageArray];
    }
    return _languages;
}

- (void)choiceLanguage:(UIButton *)btn {
    
    [self.view endEditing:YES];
    
    [self.languageMenu showFromView:btn];
    [((UITableView *)self.languageMenu.contentView) scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                          atScrollPosition:UITableViewScrollPositionTop
                                                                  animated:NO];
    [btn setSelected:YES];
    if ([btn isEqual:self.originBtn]) {
        self.showType = YTShowMenuFromViewTypeOrigin;
    } else {
        self.showType = YTShowMenuFromViewTypeDestination;
    }
}

- (void)exchangeChoiceConetent {
    
    YTLanguageCode *tempLanguage = self.originBtn.language;
    self.originBtn.language = self.destinationBtn.language;
    self.destinationBtn.language = tempLanguage;
}
#pragma mark - YTDropDownMenuDelegate
- (void)dropDownMenuDidDismissMenu:(YTDropDownMenu *)menu {
    
    self.originBtn.selected = NO;
    self.destinationBtn.selected = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.languages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTLanguageCode *language = self.languages[indexPath.row];
    
    static NSString *reuseId = @"YTLanguageCodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    [cell.textLabel setText:language.name];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YTLanguageCode *language = self.languages[indexPath.row];
    switch (self.showType) {
        case YTShowMenuFromViewTypeOrigin: {
            self.originBtn.language = language;
            break;
        }
        case YTShowMenuFromViewTypeDestination: {
            self.destinationBtn.language = language;
            break;
        }
    }
    [self.languageMenu dismiss];
}


- (YTDropDownMenu *)languageMenu {
    
    if (_languageMenu == nil) {
        YTDropDownMenu *languageMenu = [YTDropDownMenu menu]; {
            [languageMenu setDelegate:self];
            [languageMenu setContentView:({
                UITableView *contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, YTSCREEN_H*0.5)]; {
                    contentView.delegate = self;
                    contentView.dataSource = self;
                    contentView.showsVerticalScrollIndicator = NO;
                    contentView.backgroundColor = YTColor(76, 76, 76);
                }
                contentView;
            })];
        }
        _languageMenu = languageMenu;
    }
    return _languageMenu;
}

- (void)clearOriginText {
    
    self.originTextView.text = @"";
    [self.resultLabel setSize:CGSizeZero];
    [self.originTextView setHeight:YTTextViewMinH];
    [self.convertBtn setY:(self.originTextView.bottomY - self.convertBtn.height - 10)];
    [self.resultLabel setY:self.originTextView.bottomY + 10];
    [self.containView setContentSize:CGSizeMake(YTSCREEN_W, self.resultLabel.bottomY)];
}

- (void)convertOriginTextToResultText {
 
    [self.view endEditing:YES];
    
    if ([self.destinationBtn.language.code isEqualToString:self.originBtn.language.code]) {
        [YTAlertView showAlertMsg:@"原始语言与目标语言不能相同"];
        return;
    }
    
    NSDictionary *parameters = @{@"from"    : self.originBtn.language.code,
                                 @"to"      : self.destinationBtn.language.code,
                                 @"query"   : self.originTextView.text};
    
    [YTHTTPTool bdGet:APITranslateQ parameters:parameters autoShowLoading:YES success:^(id responseObject) {
        
        NSArray *reusltArray = responseObject[@"retData"][@"trans_result"];
        if ([reusltArray isKindOfClass:[NSArray class]] && reusltArray.count) {
            [self resultInfoTextString:[reusltArray firstObject][@"dst"]];
        } else {
            YTHTTPFailure(@"数据加载失败")
        }
    } failure:^(NSError *error) {
        YTHTTPFailure(@"数据加载失败")
    }];
}

- (void)resultInfoTextString:(NSString *)textString {
    
    [self.resultLabel setText:textString];
    [self.resultLabel setSize:({
        CGSize realSize = [self.resultLabel sizeThatFits:CGSizeMake(YTSCREEN_W, CGFLOAT_MAX)];
        CGSizeMake(YTSCREEN_W+2, realSize.height);
    })];
    [self.containView setContentSize:CGSizeMake(YTSCREEN_W, self.resultLabel.bottomY)];
}

@end
