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
}

+ (void)verification2:(nullable PGRouterContext *)context PGTarget("ap://tlbb/ym") {
    [context onDone:@(YES)];
}

@end
