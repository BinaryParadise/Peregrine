//
//  PGRouterGroup.m
//  Peregrine
//
//  Created by Rake Yang on 2019/9/3.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterGroup.h"

@implementation PGRouterGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        _routers = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
