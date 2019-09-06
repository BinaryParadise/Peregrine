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
    
    it(@"Map", ^{
        PGRouterNode *node = [PGRouterManager routerMap][@"tlbb"];
        expect(node.name).equal(@"tlbb");
        expect(node.config).will.beNil();
        expect(node.childs.count).beGreaterThan(@1);
    });
    
    it(@"OpenURL", ^{
        [PGRouterManager<NSNumber *> openURL:@"ap://tlbb/wyy?result=1" completion:^(BOOL ret, NSNumber * _Nonnull object) {
            expect(object.boolValue).equal(YES);
        }];
        
        [PGRouterManager openURL:@"ap://tlbb/ym" completion:^(BOOL ret, id _Nonnull object) {
            expect(object).will.beNil();
        }];
    });
    
    it(@"LoadRouter", ^{
        expect([PGRouterManager routerMap].count).equal(1);
    });
    
    it(@"UnRegister", ^{        
        [PGRouterManager openURL:@"ap://tlbb" completion:^(BOOL ret, id object) {
            expect(ret).equal(NO);
        }];
    });
    
    it(@"PGRouterConfig", ^{
        PGRouterConfig *config = [[PGRouterConfig alloc] initWithDictionary:@{@"url": @"ap://tbbb/?"}];
        expect(config.actionName).will.beNil();
        expect(config.parameters).will.beNil();
    });
    
    it(@"Parameter", ^{        
        PGRouterConfig *config = [[PGRouterConfig alloc] initWithDictionary:@{@"url": @"ap://tbbb/?c"}];
        expect(config.parameters.count).equal(1);
        config = [[PGRouterConfig alloc] initWithDictionary:@{@"url": @"ap://tbbb/?c=10000"}];
        expect(config.parameters[@"c"]).equal(@"10000");
        config = [[PGRouterConfig alloc] initWithDictionary:@{@"url": @"ap://tbbb/?c=王语嫣"}];
        expect(config.parameters[@"c"]).equal([@"王语嫣" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
        config = [[PGRouterConfig alloc] initWithDictionary:@{@"url": @"ap://tbbb/?c=t033&"}];
        expect(config.parameters.count).equal(1);
        expect(config.parameters[@"c"]).equal(@"t033");
    });
    
    it(@"MulitComponent", ^{
        PGRouterConfig *config = [[PGRouterConfig alloc] initWithDictionary:@{@"url": @"ap://tbbb/most/like/wangyuyan?t=multi"}];
        expect(config.actionName).equal(@"wangyuyan");
        expect(config.parameters[@"t"]).equal(@"multi");
    });
});

SpecEnd

