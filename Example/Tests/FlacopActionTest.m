//
//  FlacopActionTest.m
//  Flacop_Example
//
//  Created by joengzi on 2019/5/6.
//  Copyright © 2019年 joenggaa. All rights reserved.
//

#import "FlacopActionTest.h"

@implementation FlacopActionTest

+ (void)load {
    [FPRouterManager registerURL:@"fp://tlbb/duanyu?t=1"];
}

+ (void)verification1:(NSDictionary *)parameters {
    
}

@end
