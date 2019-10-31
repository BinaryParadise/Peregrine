//
//  PeregrineActionTest2.h
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/7/3.
//  Copyright © 2019 BinaryParadiase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Peregrine/Peregrine.h>

NS_ASSUME_NONNULL_BEGIN

@interface PeregrineActionTest2 : NSObject

+ (void)verification1:(nullable PGRouterContext *)context PGTarget("ap://tlbb/xlv?c=小龙女");

+ (void)multiComponent:(PGRouterContext *)context PGTarget("ap://tlbb/most/like/wangyuyan?t=multi");

PGMethod(multiComponent1, "ap://tlbb/most/like/wangzuxian?c=nice");

PGMethod(invalid, "invalidurl/haha");

@end

NS_ASSUME_NONNULL_END
