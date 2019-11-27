//
//  FPModel.h
//  Peregrine_Example
//
//  Created by Rake Yang on 2019/11/23.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPModel : NSObject

@property long number1;
@property NSString *name1;
@property void (^block1)(void);
@property (retain) void (^block2)(void);
@property (nonatomic, assign) long number2;
@property (nonatomic, copy) NSString *name2;

@end
