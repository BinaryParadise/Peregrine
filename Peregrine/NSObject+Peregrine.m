//
//  NSObject+Peregrine.m
//  Peregrine
//
//  Created by Rake Yang on 2020/1/11.
//

#import "NSObject+Peregrine.h"
#import "PGRouterManager.h"
#import "PGRouterContext.h"

@implementation NSObject (Peregrine)

- (void)pg_openURL:(NSString *)URLString completion:(void (^)(BOOL, id))completion {
    [self pg_openURL:URLString object:nil completion:completion];
}

- (void)pg_openURL:(NSString *)URLString object:(id)object completion:(void (^)(BOOL, id))completion {
    NSURL *patternURL = [NSURL pg_SafeURLWithString:URLString];
    PGRouterNode *node = [PGRouterManager routerMap][patternURL.host];
    NSMutableArray *componets = [patternURL.pathComponents mutableCopy];
    if (componets.firstObject) {
        [componets removeObject:componets.firstObject];
    }
    __block PGRouterNode *curNode = node;
    [componets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        curNode = [curNode nodeForName:obj];
        if (idx == componets.count - 1) {
            PGRouterConfig *config = curNode.config;
            if (config) {
                [self pg_openWithRouter:config context:[PGRouterContext contextWithURL:patternURL object:object callback:completion]];
            } else {
                if (completion) {
                    completion(NO, [NSString stringWithFormat:@"router: %@ no match.", URLString]);
                }
            }
        }
    }];
}

- (void)pg_openWithRouter:(PGRouterConfig *)router context:(PGRouterContext *)context {
    if ([self respondsToSelector:router.selector]) {
        context.config = router;
        IMP imp = [router.targetClass instanceMethodForSelector:router.selector];
        void (*targetMethod)(id, SEL, PGRouterContext *) = (void *)imp;
        targetMethod(self, router.selector, context);
    }
}

- (BOOL)pg_dryRun:(NSString *)URLString {
    NSURL *patternURL = [NSURL pg_SafeURLWithString:URLString];
    PGRouterNode *node = [PGRouterManager routerMap][patternURL.host];
    NSMutableArray *componets = [patternURL.pathComponents mutableCopy];
    if (componets.firstObject) {
        [componets removeObject:componets.firstObject];
    }
    __block BOOL valid = NO;
    __block PGRouterNode *context = node;
    [componets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        context = [context nodeForName:obj];
        if (idx == componets.count - 1) {
            PGRouterConfig *config = context.config;
            if (config) {
                valid = YES;
            }
        }
    }];
    return valid;
}

@end
