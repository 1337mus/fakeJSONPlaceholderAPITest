//
//  TripsDataLoader.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/24/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation

extension Date {
    static func generateRandomDate(daysBack: Int)-> Date? {
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }
}

class TripsDataLoader {
    let experiencesService = ExperiencesService()
    var dataModels = [TripsViewModel]()
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        return formatter
    }()
    
    func reloadData(completionHandler: @escaping (Bool) -> ()) {
        experiencesService.run { result in
            guard result.error == nil, let experiences = result.object else {
                DispatchQueue.main.async {
                    completionHandler(false)
                }
                return
            }
            
            experiences.forEach { experience in
                let cityName = String.generateRandomStringWithLength(length: 6)
                let tripsVM = TripsViewModel(imageURL: experience.url, cityName: cityName, address: experience.title, timestamp: self.formatter.string(from: Date.generateRandomDate(daysBack: Int(arc4random()))!))
                
                self.dataModels.append(tripsVM)
            }
            
            DispatchQueue.main.async {
                completionHandler(true)
            }
        }
    }
    
    func numberOfItems(in section: Int) -> Int {
        return dataModels.count
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func item(at indexPath: IndexPath) -> TripsViewModel {
        return dataModels[indexPath.item]
    }
}
