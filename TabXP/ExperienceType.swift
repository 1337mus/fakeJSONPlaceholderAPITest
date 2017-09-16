//
//  ExperienceType.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/15/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation


struct ExperienceType {
    let id: String
    let title: String
    
    static func fromJSON(json: [String: AnyObject]) -> ExperienceType? {
        guard let id = json["id"] as? String, let title = json["title"] as? String else { return nil }
        
        return ExperienceType(id: id, title: title)
    }
}

