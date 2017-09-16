//
//  BaseService.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/15/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation

struct ServiceResult<T> {
    let object: T?
    let error: Error?
}

typealias Parameters = [String : Any]
typealias BaseCompletionHandler = (_ isSuccess: Bool, _ json: Any?, _ error: Error?) -> Void

class BaseService {
    
    static let APIBaseHost = "https://jsonplaceholder.typicode.com"
    var dataTask: URLSessionDataTask?
    
    func requestJSON(_ endpoint: String, completionHandler: @escaping BaseCompletionHandler) {
        guard let url = URL(string: BaseService.APIBaseHost + endpoint) else {
            completionHandler(false, nil, NSError(domain: "com.array.tabxp.URLFormationError", code: 10, userInfo: nil))
            return
        }
        
        let urlSession = URLSession.shared
        
        dataTask = urlSession.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler(false, nil, error)
                return
            }
            
            // make sure we got data
            guard let responseData = data else {
                completionHandler(false, nil, NSError(domain: "com.array.tabxp.EmtpyResponseReceived", code: 11, userInfo: nil))
                return
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject]
                completionHandler(true, result, nil)
                
            } catch  {
                completionHandler(false, nil, NSError(domain: "com.array.tabxp.JSONConversionError", code: 12, userInfo: nil))
                return
            }
        }
        
        dataTask?.resume()
    }
}
