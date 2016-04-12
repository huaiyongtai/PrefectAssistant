//
//  YTCookListController.h
//  
//
//  Created by HelloWorld on 16/3/24.
//
//

#import <UIKit/UIKit.h>

@class YTCookKindItem, YTDish;

@interface YTCookListController : UITableViewController

@property (nonatomic, assign, getter=isShowSectionName) BOOL showSectionName;

@property (nonatomic, strong) YTCookKindItem *kindItem;

@property (nonatomic, copy) NSString *titleName;
+ (instancetype)cookListVCWithKindItem:(YTCookKindItem *)kindItem;
+ (instancetype)cookListVCWithDishes:(NSMutableArray<YTDish *> *)dishes;

@end
