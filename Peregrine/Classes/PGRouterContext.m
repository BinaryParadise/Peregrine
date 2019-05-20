//
//  PGRouterContext.m
//  Peregrine
//
//  Created by Rake Yang on 2019/5/13.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterContext.h"

@interface PGRouterContext ()

@property (nonatomic, assign) PGRouterCallback callback;

@end

@implementation PGRouterContext

- (instancetype)initWithCallback:(PGRouterCallback)callback {
    if (self = [super init]) {
        _callback = callback;
    }
    return self;
}

- (void)onDone:(id)object {
    
}

@end
