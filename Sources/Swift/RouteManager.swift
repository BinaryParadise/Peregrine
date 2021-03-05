//
//  RouteManager.swift
//  Peregrine
//
//  Created by Rake Yang on 2021/3/4.
//

import Foundation

public class RouteManager {
    public var routeMap: [String: RouteGroup] = [:]
    public static let shared = RouteManager()
    
    init() {
        guard let routePath = Bundle.main.path(forResource: "Peregrine.bundle/routers.json", ofType: nil) else { return }
        do {
            guard let jsonObj = try JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: routePath)), options: .mutableContainers) as? [String :  [Any]] else { return }
            registerRoute(map: jsonObj)
        } catch {
            print("\(error)")
        }
    }
    
    private func registerRoute(map: [String : [Any]]) {
        map.forEach { (key, value) in
            guard let url = URL(string: key) else { return }
            if let scheme = url.scheme, let host = url.host {
                let groupUrl = "\(scheme)://\(host)"
                var group = routeMap[groupUrl]
                if group == nil {
                    group = RouteGroup()
                    group?.url = groupUrl
                    routeMap[groupUrl] = group!
                }
                if let group = group {
                    value.forEach { (item) in
                        group.append(element: item as! [String : Any])
                    }
                }
            }
        }
    }
        
    private func invokeMethod(for node: RouteNode, context: RouteContext) -> Void {
        if let cls = node.targetClass, let sel = node.selector {
            if cls.responds(to: sel) {
                if let method = class_getClassMethod(cls, sel) {
                    let imp = method_getImplementation(method)
                    typealias Function = @convention(c) (AnyObject, Selector, RouteContext) -> Void
                    let targetMethod = unsafeBitCast(imp, to: Function.self)
                    targetMethod(cls, sel, context)
                    return
                }
            }
        }
        context.onDone(false, data: "无法找到目标函数调用")
    }
    
    public func openURL(_ url: String, object: Any? = nil, completion: ((Bool, Any?) -> Void)? = nil) {
        let routeURL = URL(string: url) ?? URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        if let routeURL = routeURL, let scheme = routeURL.scheme, let host = routeURL.host {
            if let group = routeMap["\(scheme)://\(host)"] {
                if let node = group.childs["\(scheme)://\(host)\(routeURL.path)"] {
                    let context = RouteContext(url: url, object: object, callback: completion)
                    invokeMethod(for: node, context: context)
                    return
                }
            }
        }
        completion?(false, "路由地址不合法")
    }
}

extension URL {
    static func safe(url: String) -> URL? {
        return URL(string: url) ?? URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
