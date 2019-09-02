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
        _targetClass = NSClassFromString(keyValues[PGRouterKeyClass]);
        _selector = NSSelectorFromString(keyValues[PGRouterKeySelector]);
        
        NSString *URLString = keyValues[PGRouterKeyURL];
        _URL = [NSURL URLWithString:URLString];
        if (!_URL) {
            NSString *encodeURLString = [URLString  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            _URL = [NSURL URLWithString:encodeURLString];
        }
        
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
