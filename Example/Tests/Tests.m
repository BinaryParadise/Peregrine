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
    
    it(@"RouterConfig", ^{
        PGRouterConfig *config = [[PGRouterConfig alloc] initWithDictionary:@{@"class": @"InitialSpecs", @"url": @"ap://tlbb/", @"selector": @"actionName"}];
        expect(config.actionName).will.beNil();
    });
    
    it(@"Register", ^{
        [PGRouterManager<NSNumber *> openURL:@"ap://tlbb/wyy?result=1" completion:^(BOOL ret, NSNumber * _Nonnull object) {
            expect(object.boolValue).equal(YES);
        }];
        
        [PGRouterManager openURL:@"ap://tlbb" completion:^(BOOL ret, id object) {
            expect(ret).equal(NO);
        }];
        
        expect(PGRouterManager.routerMap).willNot.beNil();
    });
});

SpecEnd

