//
//  Experience.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/15/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation

struct Experience {
    let title: String
    let id: String
    let url: String
    let thumbnailUrl: String
    let price: String
    let reviewCount: String
    
    func toJSONObject() -> [String: AnyObject] {
        var json = [String: AnyObject]()
        
        json["id"] = id as AnyObject
        json["title"] = title as AnyObject
        json["url"] = url as AnyObject
        json["thumbnailUrl"] = thumbnailUrl as AnyObject
        json["price"] = price as AnyObject
        json["reviewCount"] = reviewCount as AnyObject
        
        return json
    }
    
    static func fromJSON(json: [String: AnyObject]) -> Experience? {
        guard
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let url = json["url"] as? String,
            let thumbnailUrl = json["thumbnailUrl"] as? String
            else {
                return nil
        }
        
        
        let price = String(arc4random_uniform(500))
        let reviewCount = String(arc4random_uniform(1000))
        
        return Experience(title: title, id: String(id), url: url, thumbnailUrl: thumbnailUrl, price: price, reviewCount: reviewCount)
    }
}
