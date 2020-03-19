//
//  PGRouterManager.h
//  Peregrine
//
//  Created by Rake Yang on 2019/5/6.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGRouterNode.h"

/// 路由未实现时的通知
static NSString * const kPGDidRouterNotFoundNotificaion  = @"PGDidRouterNotFoundNotificaion";
/// 通知userinfo地址的Key
static NSString * const KPGRouterURLKey = @"PGRouterURLKey";

//类方法实现
#define PGMethod(_name, _url) \
+ (void)_name:(PGRouterContext *)context;

//实例方法实现
#define PGInstanceMethod(_name, _url) \
- (void)_name:(PGRouterContext *)context;

//使用__attribute__（暂不推荐)
#define PGMethodA(_name, _url) \
+ (void)_name:(PGRouterContext *)context  __attribute__((pe_routed(_router)));

@interface PGRouterManager<__covariant ObjectType> : NSObject

/// 完整的路由表
+ (NSDictionary<NSString *, PGRouterNode *> *)routerMap;

/**
 同步打开路由（立即回调）

 @param URLString 标准的URL地址（RFC 2396）
 @param completion 回调
 */
+ (void)openURL:(NSString *)URLString completion:(void (^)(BOOL ret, ObjectType object))completion;

/**
 同步打开路由（立即回调）

 @param URLString 标准的URL地址（RFC 2396）
 @param object 关联对象
 @param completion 回调
*/
+ (void)openURL:(NSString *)URLString object:(id)object completion:(void (^)(BOOL ret, ObjectType object))completion;

/**
 验证路由地址是否有效

 @param URLString 标准的URL地址（RFC 2396）
 */
+ (BOOL)dryRun:(NSString *)URLString;

@end
