//
//  FPTestSpec.swift
//  Peregrine_Tests
//
//  Created by Rake Yang on 2020/6/19.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

import XCTest
import Peregrine_Example

class FPTestSpec: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.        
        PGRouterManager<AnyObject>.openURL(swift_test_auth1) { (ret, obj) in
            XCTAssert(ret)
        }
        
        PGRouterManager<AnyObject>.openURL(swift_testsub_auth0) { (ret, obj) in
            XCTAssert(ret)
        }
        
        PGRouterManager<AnyObject>.openURL(swift_testsub_auth1) { (ret, obj) in
            XCTAssert(ret)
        }
        
        PGRouterManager<AnyObject>.openURL(swift_testsub_auth2) { (ret, obj) in
            XCTAssert(ret)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
