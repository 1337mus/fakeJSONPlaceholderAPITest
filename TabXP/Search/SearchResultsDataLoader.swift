//
//  SearchResultsDataLoader.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/28/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation

class SearchResultsDataLoader {
    let experienceService = ExperiencesService()
    
    func reloadData(completionHandler: @escaping (SearchResultsDataModel?) -> ()) {
        experienceService.run { result in
            guard let experiences = result.object else {
                completionHandler(nil)
                return
            }
            
            completionHandler(SearchResultsDataModel(experiences: experiences))
        }
    }
}

struct SearchResultsDataModel {
    private let sectionLetters: [String]
    private let experienceMap: [String: [Experience]]
    
    init(experiences: [Experience]) {
        var sectionLetterSet = Set<String>()
        var map = [String: [Experience]]()
        
        experiences.forEach { exp in
            let letter = exp.title[0].uppercased()
            sectionLetterSet.insert(letter)
            
            if map[letter] == nil {
                map[letter] = [Experience]()
            }
            
             map[letter]?.append(exp)
        }
        
        sectionLetters = sectionLetterSet.sorted()
        experienceMap = map
    }
    
    func item(at indexPath: IndexPath) -> [Experience]? {
        let letter = sectionLetters[indexPath.section]
        return experienceMap[letter]
    }
    
    func sectionTitle(at section: Int) -> String {
        return sectionLetters[section]
    }
    
    var sectionCount: Int {
        return sectionLetters.count
    }
    
    func numberOfItems(at section: Int) -> Int {
        let letter = sectionLetters[section]
        return experienceMap[letter]?.count ?? 0
    }
    
    func allExperiences() -> [Experience]? {
        var exp = [Experience]()
        
        for (_, exps) in experienceMap {
            exp.append(contentsOf: exps)
        }
        
        return exp
    }
}
