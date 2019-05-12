//
//  FPRouterManager.h
//  Peregrine
//
//  Created by joengzi on 2019/5/6.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import "FPRouterManager.h"

static NSString * const PGRouterKeyURL = @"url";
static NSString * const PGRouterKeyClass = @"class";
static NSString * const PGRouterKeySelector = @"selector";
static NSMutableDictionary<NSString *, NSMutableArray<NSString *> *> *_routerTable;

@implementation FPRouterManager

+ (void)initialize {
    if (!_routerTable) {     
        _routerTable = [NSMutableDictionary dictionary];
        NSString *routerPath = [[NSBundle mainBundle] pathForResource:@"Peregrine/routers.json" ofType:nil];
        NSArray<NSDictionary *> *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:routerPath] options:NSJSONReadingMutableLeaves error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *url = [obj objectForKey:PGRouterKeyURL];
                [self registerURL:url];
            }];
        }
    }
}

+ (void)registerURL:(NSString *)url {
    NSURL *patternURL = [NSURL URLWithString:url];
    NSString *prefix = [NSString stringWithFormat:@"%@://%@", patternURL.scheme, patternURL.host];
    
    NSMutableArray *routers = _routerTable[prefix];
    if (!routers) {
        routers = [NSMutableArray array];
        _routerTable[prefix] = routers;
    }
    [routers addObject:url];
}

+ (void)openURL:(NSString *)url completion:(nonnull void (^)(BOOL, NSDictionary * _Nullable))completion {
    NSURL *patternURL = [NSURL URLWithString:url];
    NSString *prefix = [NSString stringWithFormat:@"%@://%@", patternURL.scheme, patternURL.host];
    NSMutableArray<NSString *> *routers = _routerTable[prefix];
    [routers enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasPrefix:[NSString stringWithFormat:@"SELF BEGINSWITH '%@/%@'", prefix, patternURL.lastPathComponent]]) {
            if (completion) {
                completion(YES, nil);
            }
            *stop = YES;
        }
    }];
}

@end
