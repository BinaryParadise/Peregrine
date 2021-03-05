//
//  PGRouterNode.h
//  Peregrine
//
//  Created by Rake Yang on 2019/9/3.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGRouterConfig.h"

NS_ASSUME_NONNULL_BEGIN

/**
 路由树
 */
@interface PGRouterNode : NSObject

/**
 分组名称
 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) PGRouterConfig *config;


@property (nonatomic, weak) PGRouterNode *parent;

@property (nonatomic, strong) NSMutableArray<PGRouterNode *> *childs;

- (instancetype)addChildWithName:(NSString *)name;

- (instancetype)nodeForName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
