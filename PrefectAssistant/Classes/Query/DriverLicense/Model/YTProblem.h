//
//  YTProblem.h
//  PrefectAssistant
//
//  Created by HelloWorld on 16/3/31.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YTProblemCompleteStates) {
    YTProblemCompleteStateUnchoice,
    YTProblemCompleteStateChoiceSuccess,
    YTProblemCompleteStateChoiceFailure,
};

@interface YTProblem : NSObject

/**  */
@property (nonatomic, copy) NSString *idStr;

/**  */
@property (nonatomic, copy) NSString *question;
/**  */
@property (nonatomic, copy) NSString *answer;

/**  */
@property (nonatomic, copy) NSString *item1;
/**  */
@property (nonatomic, copy) NSString *item2;
/**  */
@property (nonatomic, copy) NSString *item3;
/**  */
@property (nonatomic, copy) NSString *item4;

/**  */
@property (nonatomic, copy) NSString *explains;
/**  */
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) YTProblemCompleteStates completeState;

@end
