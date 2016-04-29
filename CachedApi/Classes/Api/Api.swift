//
//  Api.swift
//  CachedApi
//
//  Created by wegie on 2016/04/29.
//  Copyright © 2016年 wegie. All rights reserved.
//

import Foundation

import Promise

public class Api {

    private let caches: Caches = Caches()

    public init() {
    }

    public final func request<T>(ns: CacheNameSpace, key: CacheKey, @autoclosure(escaping) _ supplier: () -> Promise<T>) -> Promise<T> {
        if let item = caches[ns][key] as? T {
            return .resolve(item)
        } else {
            return supplier().then {
                self.caches[ns][key] = $0
            }
        }
    }

}
