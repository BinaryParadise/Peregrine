//
//  PeregrineActionTest1.h
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/5/6.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Peregrine/Peregrine.h>

@interface PeregrineActionTest1 : NSObject

+ (void)verification1:(nullable PGRouterContext *)context PGTarget("ap://tlbb/wyy?c=王语嫣1");

+ (void)verification2:(nullable PGRouterContext *)context PGTarget("ap://tlbb/ym?c=杨幂");
@end
