//
//  FPRouterManager.h
//  Peregrine
//
//  Created by Rake Yang 2019/5/6.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterManager.h"
#import "PGRouterContext.h"

static NSMutableDictionary<NSString *, PGRouterGroup *> *_routerTable;

@interface PGRouterManager <ObjectType> ()

@end

@implementation PGRouterManager

+ (NSDictionary<NSString *,PGRouterGroup *> *)routerMap {
    return _routerTable;
}

+ (void)initialize {
    if (!_routerTable) {     
        _routerTable = [NSMutableDictionary dictionary];
        NSString *routerPath = [[NSBundle mainBundle] pathForResource:@"Peregrine.bundle/routers.json" ofType:nil];
        if (routerPath) {
            NSArray<NSDictionary *> *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:routerPath] options:NSJSONReadingMutableLeaves error:nil];
            if ([array isKindOfClass:[NSArray class]]) {
                [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self registerWithDictionary:obj];
                }];
            }
        }
    }
}

+ (void)registerWithDictionary:(NSDictionary *)dict {
    PGRouterConfig *config = [[PGRouterConfig alloc] initWithDictionary:dict];
    NSString *prefix = config.URL.host;
    if (prefix.length == 0) {
        return;
    }
    
    PGRouterGroup *group = _routerTable[prefix];
    if (!group) {
        group = [PGRouterGroup new];
        group.name = prefix;
        _routerTable[prefix] = group;
    }
    NSUInteger count = config.URL.pathComponents.count;
    [config.URL.pathComponents enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            if (idx == count - 1) {
                
            }
        }
    }];
}

+ (void)openURL:(NSString *)URLString completion:(void (^)(BOOL, id))completion {
    NSURL *patternURL = [NSURL URLWithString:URLString];
    NSMutableArray<PGRouterConfig *> *routers = _routerTable[patternURL.host];
    __block PGRouterConfig *config;
    [routers enumerateObjectsUsingBlock:^(PGRouterConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (patternURL.pathComponents.count && [obj.URL.pathComponents[1] isEqualToString:patternURL.pathComponents[1]]) {
            config = obj;
            *stop = YES;
        }
    }];
    if (config) {
        [self openWithRouter:config context:[PGRouterContext contextWithURL:patternURL callback:completion]];
    } else {
        if (completion) {
            completion(NO, [NSString stringWithFormat:@"router: %@ no match.", URLString]);
        }
    }
}

+ (void)openWithRouter:(PGRouterConfig *)router context:(PGRouterContext *)context {
    if ([router.targetClass respondsToSelector:router.selector]) {
        context.config = router;
        IMP imp = [router.targetClass methodForSelector:router.selector];
        void (*targetMethod)(id, SEL, PGRouterContext *) = (void *)imp;
        targetMethod(router.targetClass, router.selector, context);
    }
}

@end
