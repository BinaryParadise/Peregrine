//
//  ClangPeregrineTest.m
//  Peregrine_Example
//
//  Created by Rake Yang on 2021/7/8.
//  Copyright © 2021 BinaryParadise. All rights reserved.
//

#import "ClangPeregrineTest.h"
@import Peregrine;

#define __routable(__url) __attribute__((pe_routed(__url)))

@implementation ClangPeregrineTest

+ (void)enterPeregrine:(RouteContext *)context __routable("pg://hostname/helloworld") {
    
}

@end
