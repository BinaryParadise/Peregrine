//
//  SwiftRoute.swift
//  Peregrine_Example
//
//  Created by Rake Yang on 2020/6/10.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

import Foundation
import Peregrine

public class SwiftRoute {
    @available(*, renamed: "route", message: "swift://testsub/auth0")
    @objc static func test0(context: RouteContext) -> Void {
        context.onDone(true, result: "done")
    }
}

extension SwiftRoute {
    @available(*, renamed: "route", message: "swift://testsub/auth1")
    @objc static func test1(context:RouteContext) -> Void {
        context.onDone(true, result: "done")
    }
    
    @available(*, renamed: "route", message: "swift://testsub/auth2")
    @objc static func test2(context:RouteContext) -> Void {
        print(#function)
        context.onDone(true, result: nil)
    }
    
    @available(*, renamed: "route", message: "swift://testsub/url")
    @objc static func test3(context:RouteContext) -> Void {
        print(#function)
        context.onDone(true, result: context.userInfo["title"])
    }
}
