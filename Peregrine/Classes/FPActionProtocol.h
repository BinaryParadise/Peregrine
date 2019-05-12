//
//  FPActionProtocol.h
//  Peregrine
//
//  Created by joengzi on 2019/5/6.
//  Copyright © 2019 joenggaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FPAction;

NS_ASSUME_NONNULL_BEGIN

@protocol FPActionProtocol <NSObject>

@optional

- (id)targetMethodTemplate:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
