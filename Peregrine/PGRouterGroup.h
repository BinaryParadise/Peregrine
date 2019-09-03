//
//  PGRouterGroup.h
//  Peregrine
//
//  Created by Rake Yang on 2019/9/3.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 路由分组
 */
@interface PGRouterGroup : NSObject

/**
 分组名称
 */
@property (nonatomic, copy) NSString *name;

/**
 路由表
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, PGRouterGroup *> *routers;

@end

NS_ASSUME_NONNULL_END
