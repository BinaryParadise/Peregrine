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
    
    context(@"Standard", ^{
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
                expect(object).willNot.beNil();
            }];
            
            [PGRouterManager openURL:@"ap://nullable/wtf" completion:^(BOOL ret, id object) {
                expect(ret).equal(NO);
            }];
        });
        
        it(@"LoadRouter", ^{
            expect([PGRouterManager routerMap].count).equal(6);
        });
        
        it(@"UnRegister", ^{
            [PGRouterManager openURL:@"ap://tlbb" completion:^(BOOL ret, id object) {
                expect(ret).equal(NO);
            }];
            
            [PGRouterManager openURL:@"ap://tlbb/gdgx" completion:^(BOOL ret, id object) {
                expect(ret).equal(NO);
            }];
            
            waitUntil(^(DoneCallback done) {
                [PGRouterManager openURL:@"ap://zdhf/xxxx" completion:^(BOOL ret, id object) {
                    expect(ret).equal(NO);
                    done();
                }];
            });
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
            
            [PGRouterManager openURL:@"ap://tlbb/yangmi?url=http%3a%2f%2fwww.csgo.com%2fcn%3fenv%3d0%26t%3d%e9%87%8e%e8%8d%b7" completion:^(BOOL ret, NSDictionary *object) {
            }];
            
            [PGRouterManager openURL:@"swift://testsub/url?env=0&needlogin=1&title=haha" completion:^(BOOL ret, NSString *object) {
                expect(object).equal(@"swift://testsub/url?env=0&needlogin=1&title=haha");
            }];
        });
        
        it(@"MulitComponent", ^{
            PGRouterConfig *config = [[PGRouterConfig alloc] initWithDictionary:@{@"url": @"ap://tbbb/most/like/wangyuyan?t=multi"}];
            expect(config.actionName).equal(@"wangyuyan");
            expect(config.parameters[@"t"]).equal(@"multi");
            [PGRouterManager openURL:[NSString stringWithFormat:ap_tlbb_most_like_wangzuxian, 10, @"参数b"] completion:^(BOOL ret, NSDictionary *object) {
                expect(object[@"a"]).equal(@"10");
                expect(object[@"b"]).equal(@"参数b");
        }];
        });
    });
    
    context(@"", ^{
        __block PeregrineActionTest3 *test3 = [PeregrineActionTest3 new];
        
        it(@"instance", ^{
            [test3 pg_dryRun:ap_instance_method1];
            [test3 pg_openURL:ap_instance_method1 object:nil completion:^(BOOL ret, id object) {
                expect(ret).equal(YES);
            }];
            
            [test3 pg_openURL:@"ap://instance/undefined" completion:^(BOOL ret, id object) {
                expect(ret).equal(false);
            }];
        });
        
        it(@"GuideLine", ^{
            [PGRouterManager<NSString *> openURL:[NSString stringWithFormat:pg_test_m1, @"m1"] completion:^(BOOL ret, NSString *object) {
                expect(object).equal(@"m1");
            }];
            
            [PGRouterManager openURL:pg_helloworld completion:^(BOOL ret, id object) {
                expect(ret).equal(true);
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

