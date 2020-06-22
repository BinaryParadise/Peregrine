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
    }
}

public class WhatThe {
    @available(*, unavailable, renamed: "route", message: "swift://test/auth2")
    public static func a987801() {
        print(#file+" "+#function)
    }
    
    public static func a987802() {
        print(#file+" "+#function)
    }
}
