//
//  TripsVeritcalLineDecoratorView.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/23/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import UIKit

class TripsVeritcalLineDecoratorView: UICollectionReusableView {
    
    static let reusableViewIdentifier = String(describing: TripsVeritcalLineDecoratorView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Required init")
    }
    
    private func setup() {
        self.backgroundColor = UIColor.green
    }
}
