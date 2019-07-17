//
//  PeregrineTests.m
//  PeregrineTests
//
//  Created by Rake Yang on 05/06/2019.
//  Copyright (c) 2019 BinaryParadise. All rights reserved.
//

// https://github.com/Specta/Specta

#import <Peregrine/Peregrine.h>

SpecBegin(InitialSpecs)

describe(@"Lint", ^{
    it(@"OpenURL", ^{
        [PGRouterManager<NSNumber *> openURL:@"ap://tlbb/wyy?result=1" completion:^(BOOL ret, NSNumber * _Nonnull object) {
            expect(object.boolValue).equal(YES);
        }];
    });
    
    it(@"LoadRouter", ^{
        expect([PGRouterManager routerMap].allValues.firstObject.count).equal(3);
    });
    
    it(@"UnRegister", ^{        
        [PGRouterManager openURL:@"ap://tlbb" completion:^(BOOL ret, id object) {
            expect(ret).equal(NO);
        }];
    });
});

SpecEnd

