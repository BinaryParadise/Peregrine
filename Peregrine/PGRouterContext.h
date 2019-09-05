//
//  PGRouterContext.h
//  Peregrine
//
//  Created by Rake Yang on 2019/5/13.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterConfig.h"

typedef void(^PGRouterCallback)(BOOL ret, id object);

@interface PGRouterContext : NSObject

@property (nonatomic, weak) PGRouterConfig *config;
@property (nonatomic, copy, readonly) PGRouterCallback callback;
@property (nonatomic, copy, readonly) NSDictionary *userInfo;

+ (instancetype)contextWithURL:(NSURL *)openURL callback:(PGRouterCallback)callback;

/**
 路由完成

 @param ret 结果
 @param object 返回数据
 */
- (void)onDone:(BOOL)ret object:(id)object;

/**
 路由执行成功，无返回数据
 */
- (void)finished;

@end
