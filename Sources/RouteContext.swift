//
//  RouteContext.swift
//  Peregrine
//
//  Created by Rake Yang on 2021/3/5.
//

import Foundation

/// 路由调用上下文
@objc public class RouteContext: NSObject {
    var callback: ((Bool, Any?) -> Void)?
    var object: Any?
    @objc public var userInfo: [String : Any] = [ : ]
    @objc public var originURL: String = ""
    
    init(url: String, object: Any?, callback: ((Bool, Any?) -> Void)?) {
        self.originURL = url
        self.object = object
        self.callback = callback
        self.userInfo = RouteContext.queryParameters(for: URL.safe(url: url))
    }
    
    @objc public func onFinished() -> Void {
        callback?(true, nil)
    }
    
    @objc public func onDone(_ success: Bool, result: Any?) -> Void {
        callback?(success, result)
    }
    
    static func queryParameters(for url: URL?) -> [String : Any] {
        guard let url = url else { return [ : ] }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var params: [String : Any] = [ : ]
        urlComponents?.queryItems?.forEach({ (item) in
            if let value = item.value {
                params[item.name] = value
            }
        })
        return params
    }
}
