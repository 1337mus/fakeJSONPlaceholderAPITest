//
//  ExploreTableViewSectionHeaderView.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/15/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import UIKit

class ExploreTableViewSectionHeaderView: UITableViewHeaderFooterView {
    let titleLabel = UILabel()
    let actionButton = UIButton()
    
    var viewModel: ExploreSectionViewModel = ExploreSectionViewModel(title: "Explore", actionText: "See All >")  {
        didSet {
            didSetViewModel()
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupTitleLabel()
        setupActionButton()
        didSetViewModel()
    }
    
    private func setupTitleLabel() {
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.darkGray
    }
    
    private func setupActionButton() {
        self.addSubview(actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        actionButton.setTitle("See All >", for: .normal)
        actionButton.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    private func didSetViewModel() {
        titleLabel.text = viewModel.title
        actionButton.setTitle(viewModel.actionText, for: .normal)
    }
}


struct ExploreSectionViewModel {
    let title: String
    let actionText: String
}
