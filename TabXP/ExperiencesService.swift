//
//  ExperiencesService.swift.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/15/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation

typealias ExperiencesServiceCompletionHandler = (ServiceResult<[Experience]>) -> Void

class ExperiencesService: BaseService {
    
    static let endpoint = "/photos"
    
    func run(parameters: String = "", completionHandler: @escaping ExperiencesServiceCompletionHandler) {
        let params = ExperiencesService.endpoint + parameters // URL Encoded
        
        requestJSON(params) { isSuccess, response, error in
            guard isSuccess, error == nil, let results = response as? [[String: AnyObject]] else {
                completionHandler(ServiceResult<[Experience]>(object: nil, error: error))
                return
            }
            
            //let experiences: [Experience] = [Experience.fromJSON(json: result)!, Experience.fromJSON(json: result)!, Experience.fromJSON(json: result)!, Experience.fromJSON(json: result)!, Experience.fromJSON(json: result)!]
            
            let experiences = results.flatMap { Experience.fromJSON(json: $0) }
            
            completionHandler(ServiceResult<[Experience]>(object: experiences, error: nil))
        }
    }
}
