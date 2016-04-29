//
//  Cache.swift
//  CachedApi
//
//  Created by wegie on 2016/04/29.
//  Copyright © 2016年 wegie. All rights reserved.
//

import Foundation

private class CacheItem<T> {
    private let time: Int64
    private let item: T
    private init(time: Int64, item: T) {
        self.time = time
        self.item = item
    }
}

class Cache<T> {

    private let cache: NSCache = NSCache()

    private let expirationSeconds: Int

    init(expirationSeconds: Int = Int.max) {
        self.expirationSeconds = expirationSeconds
    }

    subscript(key: CacheKey) -> T? {
        get {
            if let item = cache.objectForKey(key) as? CacheItem<T> {
                return currentTime - item.time < expirationSeconds ? item.item : nil
            }
            return nil
        }
        set {
            if let value = newValue {
                cache.setObject(CacheItem(time: currentTime, item: value), forKey: key)
            } else {
                cache.removeObjectForKey(key)
            }
        }
    }

    private var currentTime: Int64 {
        return Int64(NSDate.timeIntervalSinceReferenceDate())
    }
    
}
