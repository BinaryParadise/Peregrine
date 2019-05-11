//
//  PeregrineActionTest.h
//  Peregrine_Example
//
//  Created by joengzi on 2019/5/6.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __peregrine_router(router) __attribute__((objc_peregrine_target(router)))

NS_ASSUME_NONNULL_BEGIN

@interface PeregrineActionTest : NSObject

+ (void)verification1:(NSDictionary *)parameters __peregrine_router("pr://tlbb/wyy");
+ (void)verification2:(NSDictionary *)parameters __peregrine_router("pr://tlbb/dy");

@end

NS_ASSUME_NONNULL_END
