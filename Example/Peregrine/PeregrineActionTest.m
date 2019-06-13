//
//  PeregrineActionTest.m
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/5/6.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "PeregrineActionTest.h"
#import <Peregrine/Peregrine.h>

@implementation PeregrineActionTest

+ (void)verification1:(nullable PGRouterContext *)context PGTarget("ap://tlbb/wyy") {
    NSAssert([context.config.actionName isEqualToString:@"wyy"], @"not the same");
    [context onDone:context.userInfo[@"result"]];
}

+ (void)verification2:(nullable PGRouterContext *)context PGTarget("ap://tlbb/ym") {
    
}

@end
