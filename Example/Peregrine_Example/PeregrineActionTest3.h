//
//  PeregrineActionTest2.h
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/12/24.
//  Copyright © 2019 BinaryParadiase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGRouteDefine.h"

@interface PeregrineActionTest3 : NSObject

PGMethod(verification1, "ap://tlbb/xxlv?c=小龙女");

PGInstanceMethod(instanceMethod, "ap://instance/method1");

@end
