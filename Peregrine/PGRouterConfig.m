//
//  PGRouterConfig.m
//  Peregrine
//
//  Created by Rake Yang on 2019/5/13.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterConfig.h"

@implementation NSURL (Peregrine)

+ (instancetype)pg_SafeURLWithString:(NSString *)URLString {
    NSURL *URL = [self URLWithString:URLString];
    if (!URL) {
        URL = [self URLWithString:[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }
    return URL;
}

@end

@implementation PGRouterConfig

- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSString *> *)keyValues {
    if (self = [super init]) {
        _targetClass = NSClassFromString(keyValues[PGRouterKeyClass]);
        _selector = NSSelectorFromString(keyValues[PGRouterKeySelector]);
        
        NSString *URLString = keyValues[PGRouterKeyURL];
        _URL = [NSURL pg_SafeURLWithString:URLString];        
        [self parseParameters];
    }
    return self;
}

- (void)parseParameters {
    if (_URL.query.length) {
        NSArray<NSString *> *args = [_URL.query componentsSeparatedByString:@"&"];
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
        [args enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray<NSString *> *keyValue = [obj componentsSeparatedByString:@"="];
            NSString *key = keyValue.firstObject;
            NSString *value = keyValue.lastObject;
            if (key.length && value.length) {
                mdict[key] = value;
            }
        }];
        if (mdict.count) {
            _parameters = mdict;
        }
    }
}

- (NSString *)actionName {
    if (self.URL.pathComponents.count > 1) {
        return self.URL.pathComponents.lastObject;
    }
    return nil;
}

@end
