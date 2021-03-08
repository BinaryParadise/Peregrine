//
//  PGRouterContext.m
//  Peregrine
//
//  Created by Rake Yang on 2019/5/13.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterContext.h"

@interface PGRouterContext ()

@property (nonatomic, copy) PGRouterCallback callback;
@property (nonatomic, strong) id object;
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *originURLString;

@end

@implementation PGRouterContext

- (instancetype)initWithCallback:(PGRouterCallback)callback {
    if (self = [super init]) {
        self.callback = callback;
    }
    return self;
}
    
+ (instancetype)contextWithString:(NSString *)URLString object:(id)object callback:(PGRouterCallback)callback {
    PGRouterContext *context = [[PGRouterContext alloc] initWithCallback:callback];
    NSURL *openURL = [NSURL pg_SafeURLWithString:URLString];
    context.userInfo = [self queryDictionaryForURL:openURL];
    context.object = object;
    context.originURLString = URLString;
    return context;
}

+ (NSDictionary *)queryDictionaryForURL:(NSURL *)openURL {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:openURL resolvingAgainstBaseURL:NO];
     NSMutableDictionary<NSString *, NSString *> *queryParams = [NSMutableDictionary<NSString *, NSString *> new];
     for (NSURLQueryItem *queryItem in [urlComponents queryItems]) {
         if (queryItem.value != nil) {             
             [queryParams setObject:queryItem.value forKey:queryItem.name];
         }
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
