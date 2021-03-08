//
//  FPTestSpec.swift
//  Peregrine_Tests
//
//  Created by Rake Yang on 2020/6/19.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

import XCTest
import Peregrine_Example
import Peregrine

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
        
        RouteManager.shared.openURL("pg://zoooooooo/纳尼?lang=简体中文&z=&#") { (ret, data) in
            XCTAssertFalse(ret)
        }
        
        RouteManager.shared.openURL("swift://test") { (ret, data) in
            XCTAssertFalse(ret)
        }
        
        RouteManager.shared.openURL(swift_test_auth2) { (ret, obj) in
            XCTAssert(ret)
        }
        
        RouteManager.shared.openURL(swift_test_auth3) { (ret, obj) in
            XCTAssert(ret)
        }
        
        RouteManager.shared.openURL(swift_testsub_auth0) { (ret, obj) in
            XCTAssert(ret)
        }
        
        RouteManager.shared.openURL(swift_testsub_auth1) { (ret, obj) in
            XCTAssert(ret)
        }
        
        RouteManager.shared.openURL(swift_testsub_auth2) { (ret, obj) in
            XCTAssert(ret)
        }
        
        RouteManager.shared.openURL("\(swift_testsub_url)?env=0&needlogin=1&title=haha") { (ret, data) in
            XCTAssert(ret)
            XCTAssert("haha" == data as? String ?? "")
        }
    }


}
