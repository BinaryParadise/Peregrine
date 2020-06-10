//
//  SwiftRoute.swift
//  Peregrine_Example
//
//  Created by Rake Yang on 2020/6/10.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

import Foundation

class SwiftRoute {
    
    @available(*, renamed: "route", message: "swift://test/auth2")
    func name() -> Void {
        
    }
}

extension SwiftRoute {    
    @available(*, renamed: "route", message: "swift://test/auth1")
    @objc static func test1(context:PGRouterContext) -> Void {
        print(#function)
        context.onDone(true, object: "done")
    }
    
    @available(*, renamed: "route", message: "swift://test/auth2")
    @objc static func test2(context:PGRouterContext) -> Void {
        print(#function)
    }
}
