//
//  FPRouterManager.h
//  Peregrine
//
//  Created by Rake Yang 2019/5/6.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterManager.h"
#import "PGRouterContext.h"

static NSMutableDictionary<NSString *, PGRouterNode *> *_routerTree;

@interface PGRouterManager <ObjectType> ()

@end

@implementation PGRouterManager

+ (NSDictionary<NSString *, PGRouterNode *> *)routerMap {
    return _routerTree;
}

+ (void)initialize {
    if (!_routerTree) {
        _routerTree = [NSMutableDictionary dictionary];
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
    
    PGRouterNode *node = _routerTree[prefix];
    if (!node) {
        node = [PGRouterNode new];
        node.name = prefix;
        _routerTree[prefix] = node;
    }
    NSMutableArray *components = [config.URL.pathComponents mutableCopy];
    if (components.firstObject) {
        [components removeObject:components.firstObject];
    }
    __block PGRouterNode *context = node;
    [components enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        context = [node addChildWithName:obj];
        if (idx == components.count - 1) {
            context.config = config;
        }
    }];
}

+ (void)openURL:(NSString *)URLString completion:(void (^)(BOOL, id))completion {
    NSURL *patternURL = [NSURL URLWithString:URLString];
    PGRouterNode *node = _routerTree[patternURL.host];
    NSMutableArray *componets = [patternURL.pathComponents mutableCopy];
    if (componets.firstObject) {
        [componets removeObject:componets.firstObject];
    }
    __block PGRouterNode *context = node;
    [componets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        context = [node nodeForName:obj];
        if (idx == componets.count - 1) {
            PGRouterConfig *config = context.config;
            if (config) {
                [self openWithRouter:config context:[PGRouterContext contextWithURL:patternURL callback:completion]];
            } else {
                if (completion) {
                    completion(NO, [NSString stringWithFormat:@"router: %@ no match.", URLString]);
                }
            }
        }
    }];
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
