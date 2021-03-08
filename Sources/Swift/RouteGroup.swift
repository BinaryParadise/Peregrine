//
//  RouteGroup.swift
//  Peregrine
//
//  Created by Rake Yang on 2021/3/4.
//

import Foundation

/// 路由分组（host）
public class RouteGroup {
    public var url: String = ""
    public var childs: [String : RouteNode] = [ : ]
    
    func append(element: [String : Any]) {
        let node = RouteNode()
        node.url = element["url"] as! String
        node.targetClass = NSClassFromString(element["class"] as! String)
        node.selector = NSSelectorFromString(element["selector"] as! String)
        node.swift = element["swift"] as? Bool ?? false
        if let url = URL(string: node.url) {
            childs["\(url.scheme!)://\(url.host!)\(url.path)"] = node
        }
    }
}
