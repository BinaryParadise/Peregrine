//
//  PeregrineActionTest2.m
//  Peregrine_Example
//
//  Created by lingjing on 2019/7/3.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "PeregrineActionTest2.h"

@implementation PeregrineActionTest2

+ (void)verification1:(nullable PGRouterContext *)context {
    NSAssert([context.config.actionName isEqualToString:@"wyy"], @"not the same");
    [context onDone:context.userInfo[@"result"]];
}

@end
