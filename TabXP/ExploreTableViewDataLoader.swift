//
//  ExploreTableViewDataLoader.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/15/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation

class ExploreTableViewDataLoader {
    let experiencesService = ExperiencesService()
    var exploreCellViewModel: ExploreCellViewModel?
    
    func reloadData(completionHandler: @escaping (Bool) -> ()) {
        experiencesService.run { result in
            guard result.error == nil, let experiences = result.object else {
                DispatchQueue.main.async {
                    completionHandler(false)
                }
                return
            }
            
            self.exploreCellViewModel = ExploreCellViewModel(experiences: experiences)
            
            DispatchQueue.main.async {
                completionHandler(true)
            }
        }
    }
    
    func numberOfItems(in section: Int) -> Int {
        return 1
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func item(at indexPath: IndexPath) -> Any? {
        return exploreCellViewModel
    }
}
