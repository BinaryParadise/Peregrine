//
//  TestRoute.h
//  Peregrine_Example
//
//  Created by Rake Yang on 2020/5/13.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Peregrine/Peregrine.h>

@interface TestRoute : NSObject

// 类方法路由
PGMethod(classMethod, "pg://test/m1?t=%@")

/// 实例方法路由
PGInstanceMethod(instanceMethod, "pg://test/m2?t=%@")

@end
