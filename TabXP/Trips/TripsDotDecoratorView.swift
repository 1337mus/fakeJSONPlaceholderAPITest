//
//  TripsDotDecoratorView.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/23/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation
import UIKit

class TripsDotDecoratorView: UICollectionReusableView {
    
    let dotView = UIView()
    
    static let reusableViewIdentifier = String(describing: TripsVeritcalLineDecoratorView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Required init")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dotView.layer.cornerRadius = dotView.frame.height / 2
        dotView.layer.masksToBounds = true
    }
    
    private func setup() {
        self.backgroundColor = UIColor.white
        
        self.addSubview(dotView)
        
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        dotView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        dotView.heightAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        
        dotView.backgroundColor = UIColor.green
    }
}
