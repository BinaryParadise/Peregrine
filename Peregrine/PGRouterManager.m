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
        [self registerWithFile:routerPath];
    }
}

+ (void)registerWithFile:(NSString *)file {
    if (file) {
        NSDictionary<NSString *, NSArray *> *routerMap = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:file] options:NSJSONReadingMutableLeaves error:nil];
        if ([routerMap isKindOfClass:[NSDictionary class]]) {
            [routerMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray * _Nonnull obj, BOOL * _Nonnull stop) {
                [obj enumerateObjectsUsingBlock:^(id  _Nonnull router, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self registerWithDictionary:router];
                }];
            }];
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
    if (components.count == 0) {
        node.config = config;
        return;
    }
    __block PGRouterNode *context = node;
    [components enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        context = [context addChildWithName:obj];
        if (idx == components.count - 1) {
            context.config = config;
        }
    }];
}

+ (void)openURL:(NSString *)URLString completion:(void (^)(BOOL, id))completion {
    [self openURL:URLString object:nil completion:completion];
}

+ (void)openURL:(NSString *)URLString object:(id)object completion:(void (^)(BOOL, id))completion {
    PGRouterConfig *config = [self configForURL:URLString];
    if (config) {
        [self openWithRouter:config context:[PGRouterContext contextWithString:URLString object:object callback:completion]];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPGDidRouterNotFoundNotificaion object:nil userInfo:@{KPGRouterURLKey: URLString}];
        if (completion) {
            completion(NO, [NSString stringWithFormat:@"router: %@ no match.", URLString]);
        }
    }
}

+ (PGRouterConfig *)configForURL:(NSString *)url {
    NSURL *patternURL = [NSURL pg_SafeURLWithString:url];
    PGRouterNode *node = _routerTree[patternURL.host];
    NSMutableArray *componets = [patternURL.pathComponents mutableCopy];
    if (componets.firstObject) {
        [componets removeObject:componets.firstObject];
    }
    __block PGRouterNode *curNode = node;
    [componets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        curNode = [curNode nodeForName:obj];
    }];
    return curNode.config;
}

+ (void)openWithRouter:(PGRouterConfig *)router context:(PGRouterContext *)context {
    if ([router.targetClass respondsToSelector:router.selector] || router.swift) {
        context.config = router;
        IMP imp = [router.targetClass methodForSelector:router.selector];
        if (imp != NULL) {
            void (*targetMethod)(id, SEL, PGRouterContext *) = (void *)imp;
            targetMethod(router.targetClass, router.selector, context);
        }
    }
}

+ (BOOL)dryRun:(NSString *)URLString {
    NSURL *patternURL = [NSURL pg_SafeURLWithString:URLString];
    PGRouterNode *node = _routerTree[patternURL.host];
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

+ (void)helloWorld:(PGRouterContext *)context {
    [context finished];
}

@end
