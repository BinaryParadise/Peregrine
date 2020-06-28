//
//  PeregrineTests.m
//  PeregrineTests
//
//  Created by Rake Yang on 05/06/2019.
//  Copyright (c) 2019 BinaryParadise. All rights reserved.
//

// https://github.com/Specta/Specta

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <Peregrine/Peregrine.h>
#import "PeregrineActionTest3.h"
#import "TestRoute.h"
#import "Peregrine_Tests-Swift.h"

SpecBegin(InitialSpecs)

describe(@"Lint", ^{
    
         __block PeregrineActionTest3 *test3;
         
    beforeAll(^{
        NSString *file = [[NSBundle bundleForClass:self.class] pathForResource:@"routers.json" ofType:nil];
        [PGRouterManager performSelector:@selector(registerWithFile:) withObject:file];
        test3 = [PeregrineActionTest3 new];
    });
    
    it(@"Map", ^{
        PGRouterNode *node = [PGRouterManager routerMap][@"tlbb"];
        expect(node.name).equal(@"tlbb");
        expect(node.config).will.beNil();
        expect(node.childs.count).beGreaterThan(@1);
    });
    
    it(@"OpenURL", ^{
        if ([PGRouterManager dryRun:ap_tlbb_wyy]) {
            [PGRouterManager<NSNumber *> openURL:[NSString stringWithFormat:ap_tlbb_wyy, 1] completion:^(BOOL ret, NSNumber * _Nonnull object) {
                expect(object.boolValue).equal(YES);
            }];
        }
        
        [PGRouterManager openURL:ap_tlbb_yangmi completion:^(BOOL ret, id _Nonnull object) {
            expect(object).will.beNil();
        }];
        
        [PGRouterManager openURL:@"ap://nullable/wtf" completion:^(BOOL ret, id object) {
            expect(ret).equal(NO);
        }];
    });
    
    it(@"LoadRouter", ^{
        expect([PGRouterManager routerMap].count).equal(5);
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
    [PGRouterManager openURL:[NSString stringWithFormat:ap_tlbb_most_like_wangzuxian, 10, @"参数b"] completion:^(BOOL ret, NSDictionary *object) {
        expect(object[@"a"]).equal(@"10");
        expect(object[@"b"]).equal(@"参数b");
    }];
    
    it(@"instance", ^{
        [test3 pg_dryRun:ap_instance_method1];
        [test3 pg_openURL:ap_instance_method1 object:nil completion:^(BOOL ret, id object) {
            expect(ret).equal(YES);
        }];
    });
    
    it(@"GuideLine", ^{
        [PGRouterManager<NSString *> openURL:[NSString stringWithFormat:pg_test_m1, @"m1"] completion:^(BOOL ret, NSString *object) {
            expect(object).equal(@"m1");
        }];
        
        //实例方法
        TestRoute *test = [TestRoute new];
        //路由地址可直接使用字符串（推荐导入PGRouteDefine.h使用常量定义）
        [test pg_openURL:[NSString stringWithFormat:pg_test_m2, @"m2"] completion:^(BOOL ret, id object) {
          //TODO: do something
            expect(object).equal(@"m2");
        }];
    });    
    
    });
});

SpecEnd

