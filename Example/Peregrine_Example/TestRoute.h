//
//  TestRoute.h
//  Peregrine_Example
//
//  Created by Rake Yang on 2020/5/13.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RouteDefine.h"

@interface TestRoute : NSObject

// 类方法路由
RouteDefine(classMethod, "pg://test/m1?t=%@")

@end
