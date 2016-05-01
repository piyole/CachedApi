//
//  HTTPRequestPath.swift
//  CachedApi
//
//  Created by wegie on 2016/05/01.
//  Copyright © 2016年 wegie. All rights reserved.
//

import Foundation

public struct HTTPRequestPath {

    private let path: String

    public init(_ path: String) {
        self.path = path
    }

}

extension HTTPRequestPath {

    public func param(name: String, _ value: Int) -> HTTPRequestPath {
        return param(name, String(value))
    }

    public func param(name: String, _ value: String) -> HTTPRequestPath {
        let path = self.path.stringByReplacingOccurrencesOfString(String(format: "{%@}", name), withString: value)
        return HTTPRequestPath(path)
    }

    public func param(name: String, format: String, _ args: CVarArgType...) -> HTTPRequestPath {
        return param(name, String(format: format, arguments: args))
    }

}

extension HTTPRequestPath {

    func path(host: String) -> String {
        return host + path
    }
    
}

public func == (lhs: HTTPRequestPath, rhs: HTTPRequestPath) -> Bool {
    return lhs.path == rhs.path
}
