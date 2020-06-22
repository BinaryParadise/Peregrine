//
//  FPSwiftTestSpec.m
//  Peregrine_Tests
//
//  Created by Rake Yang on 2020/6/10.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

#import "PGRouteDefine.h"

SpecBegin(FPSwiftTestSpec)

describe(@"Route", ^{
    context(@"Swift", ^{
    it(@"Standard", ^{
        [PGRouterManager openURL:swift_test_auth1 completion:^(BOOL ret, id object) {
            expect(ret).equal(YES);
            expect(object).equal(@"done");
        }];
        
        [PGRouterManager openURL:swift_testsub_auth1 completion:^(BOOL ret, id object) {
            expect(ret).equal(YES);
            expect(object).equal(@"done");
        }];
    });
});
});

SpecEnd
