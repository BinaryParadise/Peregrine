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
    PGRouterConfig *config = [PGRouterManager configForURL:URLString];
    if (config) {
        [self pg_openWithRouter:config context:[PGRouterContext contextWithURL:[NSURL pg_SafeURLWithString:URLString] object:object callback:completion]];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPGDidRouterNotFoundNotificaion object:nil userInfo:@{KPGRouterURLKey: URLString}];
        if (completion) {
            completion(NO, [NSString stringWithFormat:@"router: %@ no match.", URLString]);
        }
    }}

- (void)pg_openWithRouter:(PGRouterConfig *)router context:(PGRouterContext *)context {
    if ([self respondsToSelector:router.selector]) {
        context.config = router;
        IMP imp = [router.targetClass instanceMethodForSelector:router.selector];
        void (*targetMethod)(id, SEL, PGRouterContext *) = (void *)imp;
        targetMethod(self, router.selector, context);
    }
}

- (BOOL)pg_dryRun:(NSString *)URLString {
    return [PGRouterManager dryRun:URLString];
}

@end
