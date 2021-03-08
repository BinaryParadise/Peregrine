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

PGMethod(verification1, "ap://tlbb/xlv?c=小龙女");

PGMethod(multiComponent, "ap://tlbb/most/like/wangyuyan?t=multi");

PGMethod(multiComponent1, "ap://tlbb/most/like/wangzuxian?c=nice&a=%d&b=%@");

PGMethod(invalid, "invalidurl/haha");

@end

NS_ASSUME_NONNULL_END
