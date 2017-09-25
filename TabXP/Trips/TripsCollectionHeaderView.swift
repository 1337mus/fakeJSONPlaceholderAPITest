//
//  TripsCollectionHeaderView.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/24/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation
import UIKit

class TripsCollectionHeaderView: UICollectionReusableView {
    let titleLabel = UILabel()
    let timeStampLabel = UILabel()
    
    var viewModel = TripsHeaderViewModel(title: "", timeStamp: "") {
        didSet {
            didSetViewModel()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = UIColor.white
        setupTitleLabel()
        setupTimestampLabel()
    }
    
    private func setupTitleLabel() {
        self.addSubview(titleLabel)
        
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium)
        titleLabel.textColor = UIColor.black
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
    }
    
    
    private func setupTimestampLabel() {
        self.addSubview(timeStampLabel)
        
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        timeStampLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        timeStampLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = false
        timeStampLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    }
    
    private func didSetViewModel() {
        titleLabel.text = viewModel.title
        timeStampLabel.text = viewModel.timeStamp
    }
}

struct TripsHeaderViewModel {
    let title: String
    let timeStamp: String
}


