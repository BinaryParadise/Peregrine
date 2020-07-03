//
//  SwiftRoute.swift
//  Peregrine_Example
//
//  Created by Rake Yang on 2020/6/10.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

import Foundation

public class SwiftRoute {
}

extension SwiftRoute {    
    @available(*, renamed: "route", message: "swift://test/auth1")
    @objc static func test1(context:PGRouterContext) -> Void {
        print(#file+" "+#function)
        context.onDone(true, object: "done")
    }
    
    @available(*, renamed: "route", message: "swift://test/auth2")
    @objc static func test2(context:PGRouterContext) -> Void {
        print(#function)
        context.onDone(true, object: nil)
    }
}

public class WhatThe {
    @available(*, renamed: "route", message: "swift://test/auth3")
    @objc static func a987801(context:PGRouterContext) {
        print(#file+" "+#function)
        context.onDone(true, object: nil)
    }

    @available(*, renamed: "route", message: "swift://test/auth4")
    @objc static func a987802(context: PGRouterContext) -> Void {
        print(#file+" "+#function)
        context.onDone(true, object: nil)
    }
}
