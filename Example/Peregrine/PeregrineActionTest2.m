//
//  PeregrineActionTest2.m
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/7/3.
//  Copyright © 2019 BinaryParadiase. All rights reserved.
//

#import "PeregrineActionTest2.h"

@implementation PeregrineActionTest2

+ (void)verification1:(PGRouterContext *)context {
    NSAssert([context.config.actionName isEqualToString:@"xlv"], @"not the same");
    [context onDone:YES object:context.userInfo[@"result"]];
}

+ (void)multiComponent:(PGRouterContext *)context {
    [context onDone:YES object:context.config.actionName];
}

+ (void)multiComponent1:(PGRouterContext *)context {
    [context onDone:YES object:context.userInfo];
}

+ (void)invalid:(PGRouterContext *)context {
    
}

@end
