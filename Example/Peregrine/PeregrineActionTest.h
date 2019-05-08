//
//  PeregrineActionTest.h
//  Peregrine_Example
//
//  Created by joengzi on 2019/5/6.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Peregrine/Peregrine.h>

NS_ASSUME_NONNULL_BEGIN

@interface PeregrineActionTest : NSObject

+ (void)verification1:(NSDictionary *)parameters FPRouterTarget("fp://天龙八部/段誉");

+ (void)verification2:(NSDictionary *)parameters FPRouterTarget("fp://天龙八部/王语嫣");

+ (void)deprecatedMethod __deprecated_msg("已过期");

@end

NS_ASSUME_NONNULL_END
