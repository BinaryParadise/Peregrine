//
//  PGRouterNode.m
//  Peregrine
//
//  Created by Rake Yang on 2019/9/3.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterNode.h"

@interface PGRouterNode ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, PGRouterNode *> *map;


@end

@implementation PGRouterNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        _childs = [NSMutableArray array];
        _map = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)addChildWithName:(NSString *)name {
    PGRouterNode *node = [PGRouterNode new];
    node.name = name;
    node.parent = self;
    [self.childs addObject:node];
    self.map[name] = node;
    return node;
}

- (instancetype)nodeForName:(NSString *)name {
    return self.map[name];
}

@end
