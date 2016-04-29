//
//  Caches.swift
//  CachedApi
//
//  Created by wegie on 2016/04/29.
//  Copyright © 2016年 wegie. All rights reserved.
//

import Foundation

class Caches {

    private var caches: [String : Cache<Any>] = [:]

    subscript(ns: CacheNameSpace) -> Cache<Any> {
        var cache = caches[ns.name]
        if cache == nil {
            cache = Cache<Any>(expirationSeconds: ns.expirationSeconds)
            caches[ns.name] = cache
        }
        return cache!
    }

}
