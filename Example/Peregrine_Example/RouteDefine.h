//
//  RouteDefine.h
//  Peregrine_Example
//
//  Created by Rake Yang on 2021/4/12.
//  Copyright © 2021 BinaryParadise. All rights reserved.
//

#ifndef RouteDefine_h
#define RouteDefine_h

@import Peregrine;

//创建路由
#define RouteDefine(func, _url) \
+ (void)func:(RouteContext *)context;

#endif /* RouteDefine_h */
