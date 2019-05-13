//
//  PGRouterContext.h
//  Peregrine
//
//  Created by Rake Yang on 2019/5/13.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PGRouterCallback)(BOOL ret, id object);

@interface PGRouterContext : NSObject

- (instancetype)initWithCallback:(PGRouterCallback)callback;

- (void)onDone:(id)object;

@end

NS_ASSUME_NONNULL_END
