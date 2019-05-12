//
//  PeregrineActionTest.m
//  Peregrine_Example
//
//  Created by joengzi on 2019/5/6.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "PeregrineActionTest.h"
#import <Peregrine/Peregrine.h>

@implementation PeregrineActionTest

+ (id)verification1:(NSDictionary *)parameters __attribute__((pe_routed("ap://tlbb/wyy"))) {
    return nil;
}

+ (id)verification2:(NSDictionary *)parameters __attribute__((pe_routed("ap://tlbb/mwq"))) {
    return @(0);
}

@end
