//
//  PeregrineActionTest.m
//  Peregrine_Example
//
//  Created by joengzi on 2019/5/6.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "PeregrineActionTest.h"

@implementation PeregrineActionTest

+ (id)verification1:(NSDictionary *)parameters __peregrine_router("ap://tlbb/wyy") {
    return nil;
}

+ (void)verification2:(NSDictionary *)parameters __peregrine_router("ap://tlbb/dy") {
    
}

+ (id)verification3:(NSDictionary *)parameters __peregrine_router("ap://tlbb/mwq") {
    return @(0);
}

@end
