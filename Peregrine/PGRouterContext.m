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
    
+ (instancetype)contextWithString:(NSString *)URLString object:(id)object callback:(PGRouterCallback)callback {
    PGRouterContext *context = [[PGRouterContext alloc] initWithCallback:callback];
    NSURL *openURL = [NSURL pg_SafeURLWithString:URLString];
    context->_userInfo = [self queryDictionaryForURL:openURL];
    context->_object = object;
    context->_originURLString = URLString;
    return context;
}

+ (NSDictionary *)queryDictionaryForURL:(NSURL *)openURL {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:openURL resolvingAgainstBaseURL:NO];
     NSMutableDictionary<NSString *, NSString *> *queryParams = [NSMutableDictionary<NSString *, NSString *> new];
     for (NSURLQueryItem *queryItem in [urlComponents queryItems]) {
         if (queryItem.value == nil) {
             continue;
         }
         [queryParams setObject:queryItem.value forKey:queryItem.name];
     }
     return queryParams;
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
