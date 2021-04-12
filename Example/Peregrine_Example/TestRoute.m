//
//  TestRoute.m
//  Peregrine_Example
//
//  Created by Rake Yang on 2020/5/13.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

#import "TestRoute.h"

@implementation TestRoute

+ (void)classMethod:(RouteContext *)context {
    //context.userInfo：包含携带的参数
    //context.object: 表示传的对象类型参数
    [context onDone:YES result:[context.userInfo valueForKey:@"t"]];
}

- (void)instanceMethod:(RouteContext *)context {
    [context onDone:YES result:[context.userInfo valueForKey:@"t"]];
}

@end
