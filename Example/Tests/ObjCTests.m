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
#import "PeregrineActionTest3.h"
#import "TestRoute.h"
#import "Peregrine_Example_Tests-Swift.h"
@import Peregrine;

SpecBegin(InitialSpecs)

describe(@"Lint", ^{
    
    context(@"Standard", ^{
        it(@"OpenURL", ^{
            [RouteManager openURL:[NSString stringWithFormat:@"ap://tlbb/wyy?c=王语嫣1&result=%d", 1] object:nil completion:^(BOOL ret, NSNumber * _Nonnull object) {
                expect(ret).equal(YES);
            }];
            
            [RouteManager openURL:@"ap://tlbb/yangmi" object:nil completion:^(BOOL ret, id _Nonnull object) {
                expect(object).willNot.beNil();
            }];
            
            [RouteManager openURL:@"ap://nullable/wtf" object:nil completion:^(BOOL ret, id object) {
                expect(ret).equal(NO);
            }];
        });
        
        it(@"UnRegister", ^{
            [RouteManager openURL:@"ap://tlbb" object:nil completion:^(BOOL ret, id object) {
                expect(ret).equal(NO);
            }];
            
            [RouteManager openURL:@"ap://tlbb/gdgx" object:nil completion:^(BOOL ret, id object) {
                expect(ret).equal(NO);
            }];
            
            waitUntil(^(DoneCallback done) {
                [RouteManager openURL:@"ap://zdhf/xxxx" object:nil completion:^(BOOL ret, id object) {
                    expect(ret).equal(NO);
                    done();
                }];
            });
        });
        
        it(@"MulitComponent", ^{
            [RouteManager openURL:[NSString stringWithFormat:@"ap://tlbb/most/like/wangzuxian?c=nice&a=%d&b=%@", 10, @"参数b"] object:nil completion:^(BOOL ret, NSDictionary *object) {
                expect(object[@"a"]).equal(@"10");
                expect(object[@"b"]).equal(@"参数b");
        }];
        });
    });
    
    context(@"", ^{
        
        it(@"GuideLine", ^{
            [RouteManager openURL:[NSString stringWithFormat:@"pg://test/m1?t=%@", @"m1"] object:nil completion:^(BOOL ret, NSString *object) {
                expect(object).equal(@"m1");
            }];            
        });
    });
        
});

SpecEnd

