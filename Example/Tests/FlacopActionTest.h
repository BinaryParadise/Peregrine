//
//  FlacopActionTest.h
//  Flacop_Example
//
//  Created by joengzi on 2019/5/6.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flacop/Flacop.h>

NS_ASSUME_NONNULL_BEGIN

FPRouterModule("天龙八部")
@interface FlacopActionTest : NSObject

+ (void)verification1:(NSDictionary *)parameters FPRouterTarget("fp://天龙八部/段誉");

@end

NS_ASSUME_NONNULL_END
