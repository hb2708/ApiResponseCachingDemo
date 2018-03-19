//
//  HBRequestManager.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//

import UIKit

public enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

open class HBRequestManager: NSObject {
    
    open static func performRequestOn(_ url: URL?, method: HTTPMethod = .get, body: [String:String]? = nil, headers: [String:String]? = nil, isCacheEnable: Bool = false, timeoutAfter timeout: TimeInterval = 5, completion:@escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = url else {
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: timeout)
        
        if isCacheEnable, let data = HBCacher.checkAndGetObjectFromCacheFor(urlRequest) {
            completion(data, nil)
            return
        }
        
        do {
            if var headers = headers {
                let bodyData = try JSONSerialization.data(withJSONObject: body ?? "", options: .prettyPrinted)
                urlRequest.httpBody = bodyData
                headers["Content-Type"] = "application/json"
            }
        } catch{
            print("Invalid JSON BODY")
        }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                if let error = error {
                    completion(nil, error)
                } else {
                    if isCacheEnable {
                        HBCacher.storeObjectInCacheFor(urlRequest as URLRequest, response: response, data: data)
                    }
                    completion(data, nil)
                }
            })
        }
        task.resume()
    }
}
