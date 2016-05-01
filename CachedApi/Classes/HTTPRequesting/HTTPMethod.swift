//
//  HTTPMethod.swift
//  CachedApi
//
//  Created by wegie on 2016/05/01.
//  Copyright © 2016年 wegie. All rights reserved.
//

import Alamofire

public enum HTTPMethod {

    case Get
    case Post
    case Put

}

extension HTTPMethod {

    var method: Alamofire.Method {
        switch self {
        case .Get:
            return .GET
        case .Post:
            return .POST
        case .Put:
            return .PUT
        }
    }

}
