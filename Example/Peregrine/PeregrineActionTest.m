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

+ (id)verification1:(NSDictionary *)parameters context:(PGRouterContext *)context PG_Target("ap://tlbb/wyy") {
    return nil;
}

+ (void)verification2:(NSDictionary *)parameters context:(PGRouterContext *)context PG_Target("ap://tlbb/ym") {
    [context onDone:@(YES)];
}

@end
