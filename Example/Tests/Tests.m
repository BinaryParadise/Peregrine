//
//  PeregrineTests.m
//  PeregrineTests
//
//  Created by Rake Yang on 05/06/2019.
//  Copyright (c) 2019 BinaryParadise. All rights reserved.
//

// https://github.com/Specta/Specta

#import "PeregrineActionTest.h"

SpecBegin(InitialSpecs)

describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        [FPRouterManager openURL:@"fp://tlbb/duanyu?t=1" completion:^(BOOL success, NSDictionary * _Nonnull result) {
            expect(success).equal(YES);
        }];
    });
});

SpecEnd

