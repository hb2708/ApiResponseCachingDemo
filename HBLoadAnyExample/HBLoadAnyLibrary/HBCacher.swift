//
//  HBCacher.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//

import UIKit

class HBCacher: NSObject {
    public static func configureCacheWith(_ memorySizeInMB: Int = 10, diskSizeInMB: Int = 20) {
        let inMemoryCacheSize = memorySizeInMB * 1024 * 1024
        let onDiskCacheSize = diskSizeInMB * 1024 * 1024
        let cache = URLCache(memoryCapacity: inMemoryCacheSize, diskCapacity: onDiskCacheSize, diskPath: nil)
        URLCache.shared = cache
    }
    
    public static func clearCachedObjects() {
        URLCache.shared.removeAllCachedResponses()
    }

    public static func checkAndGetObjectFromCacheFor(_ urlRequest: URLRequest) -> Data? {
        if let object = URLCache.shared.cachedResponse(for: urlRequest) {
            return object.data
        }
        return nil
    }
    
    public static func storeObjectInCacheFor(_ urlRequest: URLRequest?, response: URLResponse?, data: Data?) {
        guard let urlRequest = urlRequest, let response = response, let data = data else{
            return
        }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
