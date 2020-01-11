//
//  NSObject+Peregrine.h
//  Peregrine
//
//  Created by Rake Yang on 2020/1/11.
//

#import <Foundation/Foundation.h>

/// 示例的路由实现
@interface NSObject (Peregrine)

/// 打开路由
/// @param URLString 路由地址
/// @param completion 回调
- (void)pg_openURL:(NSString *)URLString completion:(void (^)(BOOL ret, id object))completion;

/// 打开路由
/// @param URLString 路由地址
/// @param object 参数对象
/// @param completion 回调
- (void)pg_openURL:(NSString *)URLString object:(id)object completion:(void (^)(BOOL ret, id object))completion;

/// 校验路由是否生效
/// @param URLString 路由地址
- (BOOL)pg_dryRun:(NSString *)URLString;

@end
