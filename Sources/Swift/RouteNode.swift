//
//  RouteManager.swift
//  Peregrine
//
//  Created by Rake Yang on 2021/3/4.
//

import Foundation

public class RouteNode {
    var swift: Bool = false
    var targetClass: AnyClass?
    var selector: Selector?
    public var url: String = ""
}
