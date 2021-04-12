//
//  RouteManager.swift
//  Peregrine
//
//  Created by Rake Yang on 2021/3/4.
//

import Foundation

public class RouteManager: NSObject {
    public var routeMap: [String: RouteGroup] = [:]
    public static let shared = RouteManager()
    
    override init() {
        super.init()
        if let routePath = Bundle.main.path(forResource: "Peregrine.bundle/Routes.json", ofType: nil) {
            if let jsonObj = try? JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: routePath)), options: .mutableContainers) as? [String :  [Any]] {                
                registerRoute(map: jsonObj)
            }
        }
    }
    
    private func registerRoute(map: [String : [Any]]?) {
        map?.forEach { (key, value) in
            guard let url = URL.safe(url: key) else { return }
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
        
    private static func invokeMethod(for node: RouteNode, context: RouteContext) -> Void {
        if let cls = node.targetClass, let sel = node.selector {
            if cls.responds(to: sel) {
                if let method = class_getClassMethod(cls, sel) {
                    let imp = method_getImplementation(method)
                    typealias Function = @convention(c) (AnyObject, Selector, RouteContext) -> Void
                    let targetMethod = unsafeBitCast(imp, to: Function.self)
                    targetMethod(cls, sel, context)
                }
            }
        }
    }
    
    @objc public static func dryRun(_ url: String) -> Bool {
        let routeURL = URL.safe(url: url)
        if let routeURL = routeURL, let scheme = routeURL.scheme, let host = routeURL.host {
             if let group = shared.routeMap["\(scheme)://\(host)"] {
                 if let _ = group.childs["\(scheme)://\(host)\(routeURL.path)"] {
                     return true
                 }
             }
        }
        return false
    }

    
    @objc @discardableResult static public func openURL(_ url: String, object: Any? = nil, completion: ((Bool, Any?) -> Void)? = nil) -> Bool {
        let routeURL = URL.safe(url: url)
        if let routeURL = routeURL, let scheme = routeURL.scheme, let host = routeURL.host {
            if let group = shared.routeMap["\(scheme)://\(host)"] {
                if let node = group.childs["\(scheme)://\(host)\(routeURL.path)"] {
                    let context = RouteContext(url: url, object: object) { (ret, data) in
                        completion?(ret, data)
                    }
                    invokeMethod(for: node, context: context)
                    return true
                }
            }
        }
        completion?(false, "路由地址不合法或未找到对应实现")
        return false
    }
}

extension URL {
    static func safe(url: String) -> URL? {
        return URL(string: url) ?? URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
