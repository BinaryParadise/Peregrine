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
}

extension SwiftRoute {    
    @available(*, renamed: "route", message: "swift://test/auth1")
    @objc static func test1(context:RouteContext) -> Void {
        print(#file+" "+#function)
        context.onDone(true, result: "done")
    }
    
    @available(*, renamed: "route", message: "swift://test/auth2")
    @objc static func test2(context:RouteContext) -> Void {
        print(#function)
        context.onFinished()
    }
}

public class WhatThe {
    @available(*, renamed: "route", message: "swift://test/auth3")
    @objc static func a987801(context:RouteContext) {
        print(#file+" "+#function)
        context.onDone(true, result: nil)
    }

    @available(*, renamed: "route", message: "")
    @objc static func a987802(context: RouteContext) -> Void {
        print(#file+" "+#function)
        context.onFinished()
    }
}
