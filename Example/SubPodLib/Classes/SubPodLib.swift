//
//  SwiftRoute.swift
//  Peregrine_Example
//
//  Created by Rake Yang on 2020/6/10.
//  Copyright © 2020 BinaryParadise. All rights reserved.
//

import Foundation
import Peregrine

class SwiftRoute {
    
}

extension SwiftRoute {
    @available(*, renamed: "route", message: "swift://testsub/auth1")
    @objc static func test1(context:PGRouterContext) -> Void {
        context.onDone(true, object: "done")
    }
    
    @available(*, renamed: "route", message: "swift://testsub/auth2")
    @objc static func test2(context:PGRouterContext) -> Void {
        print(#function)
    }
}
