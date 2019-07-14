//
//  PeregrineActionTest2.m
//  Peregrine_Example
//
//  Created by lingjing on 2019/7/3.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "PeregrineActionTest2.h"
#import <Peregrine/Peregrine.h>

@implementation PeregrineActionTest2

+ (void)verification1:(nullable PGRouterContext *)context PGTarget("ap://tlbb/xlv?c=小龙女") {
    NSAssert([context.config.actionName isEqualToString:@"wyy"], @"not the same");
    [context onDone:context.userInfo[@"result"]];
}

@end
