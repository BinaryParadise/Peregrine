//
//  PGRouterConfig.m
//  Peregrine
//
//  Created by Rake Yang on 2019/5/13.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterConfig.h"

@implementation PGRouterConfig

- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSString *> *)keyValues {
    if (self = [super init]) {
        _URL = [NSURL URLWithString:keyValues[PGRouterKeyURL]];
        _targetClass = NSClassFromString(keyValues[PGRouterKeyClass]);
        _selector = NSSelectorFromString(keyValues[PGRouterKeySelector]);
    }
    return self;
}

@end
