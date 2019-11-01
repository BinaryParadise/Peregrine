//
//  PGRouterContext.m
//  Peregrine
//
//  Created by Rake Yang on 2019/5/13.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterContext.h"

@interface PGRouterContext ()

@end

@implementation PGRouterContext

- (instancetype)initWithCallback:(PGRouterCallback)callback {
    if (self = [super init]) {
        _callback = callback;
    }
    return self;
}
    
+ (instancetype)contextWithURL:(NSURL *)openURL object:(id)object callback:(PGRouterCallback)callback {
    PGRouterContext *context = [[PGRouterContext alloc] initWithCallback:callback];
    context->_userInfo = [self queryDictionaryForURL:openURL];
    context->_object = object;
    return context;
}

+ (NSDictionary *)queryDictionaryForURL:(NSURL *)openURL {
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    [[openURL.query componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.length) {
            NSArray<NSString *> *arr = [obj componentsSeparatedByString:@"="];
            mdict[arr.firstObject] = arr.lastObject.length ? arr.lastObject : @"";
        }
    }];
    return mdict.count ? mdict : nil;
}

- (void)onDone:(BOOL)ret object:(id)object {
    if (self.callback) {
        self.callback(ret, object);
    }
}

- (void)finished {
    [self onDone:YES object:nil];
}

@end
