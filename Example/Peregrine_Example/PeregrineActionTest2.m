//
//  PeregrineActionTest2.m
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/7/3.
//  Copyright © 2019 BinaryParadiase. All rights reserved.
//

#import "PeregrineActionTest2.h"

@implementation PeregrineActionTest2

+ (void)verification1:(RouteContext *)context {
    [context onDone:YES result:context.userInfo[@"result"]];
}

+ (void)multiComponent:(RouteContext *)context {
    [context onDone:YES result:context.originURL];
}

+ (void)multiComponent1:(RouteContext *)context {
    [context onDone:YES result:context.userInfo];
}

+ (void)invalid:(RouteContext *)context {
    
}

@end
