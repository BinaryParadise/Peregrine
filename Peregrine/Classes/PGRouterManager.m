//
//  FPRouterManager.h
//  Peregrine
//
//  Created by Rake Yang 2019/5/6.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterManager.h"
#import "PGRouterConfig.h"

static NSMutableDictionary<NSString *, NSMutableArray<PGRouterConfig *> *> *_routerTable;

@interface PGRouterManager <ObjectType> ()

@end

@implementation PGRouterManager

+ (NSDictionary<NSString *,NSArray<PGRouterConfig *> *> *)routerMap {
    return _routerTable;
}

+ (void)initialize {
    if (!_routerTable) {     
        _routerTable = [NSMutableDictionary dictionary];
        NSString *routerPath = [[NSBundle mainBundle] pathForResource:@"Peregrine/routers.json" ofType:nil];
        NSArray<NSDictionary *> *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:routerPath] options:NSJSONReadingMutableLeaves error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self registerWithDictionary:obj];
            }];
        }
    }
}

+ (void)registerWithDictionary:(NSDictionary *)dict {
    PGRouterConfig *router = [[PGRouterConfig alloc] initWithDictionary:dict];
    NSString *prefix = router.URL.host;
    if (prefix.length == 0) {
        return;
    }
    
    NSMutableArray *routers = _routerTable[prefix];
    if (!routers) {
        routers = [NSMutableArray array];
        _routerTable[prefix] = routers;
    }
    [routers addObject:router];
}

+ (void)openURL:(NSString *)URLString completion:(nonnull void (^)(id _Nullable))completion {
    NSURL *patternURL = [NSURL URLWithString:URLString];
    NSMutableArray<PGRouterConfig *> *routers = _routerTable[patternURL.host];
    [routers enumerateObjectsUsingBlock:^(PGRouterConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.URL.pathComponents[1] isEqualToString:patternURL.pathComponents[1]]) {
            [self openWithRouter:obj];
            if (completion) {
                completion(nil);
            }
            *stop = YES;
        }
    }];
}

+ (void)openWithRouter:(PGRouterConfig *)router {
    if ([router.targetClass respondsToSelector:router.selector]) {
        IMP imp = [router.targetClass methodForSelector:router.selector];
        void (*targetMethod)(id, SEL, id) = (void *)imp;
        targetMethod(router.targetClass, router.selector, router);
    }
}

@end
