//
//  PGRouterContext.h
//  Peregrine
//
//  Created by Rake Yang on 2019/5/13.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "PGRouterConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PGRouterCallback)(BOOL ret, id object);

@interface PGRouterContext : NSObject

@property (nonatomic, weak) PGRouterConfig *config;
@property (nonatomic, copy, readonly) PGRouterCallback callback;
@property (nonatomic, copy, readonly) NSDictionary *userInfo;

+ (instancetype)contextWithURL:(NSURL *)openURL callback:(PGRouterCallback)callback;

- (void)onDone:(id)object;

@end

NS_ASSUME_NONNULL_END
