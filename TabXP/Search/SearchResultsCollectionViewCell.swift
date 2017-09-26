//
//  SearchResultsCollectionViewCell.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/25/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import UIKit

class SearchResultsCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    var viewModel: SearchResultsViewModel = SearchResultsViewModel(imageURL: "", title: "", description: "") {
        didSet {
            didSetViewModel()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        didSetViewModel()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 2/3).isActive = true
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
        titleLabel.textColor = UIColor.darkText
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.numberOfLines = 0
    }
    
    private func didSetViewModel() {
        imageView.downloadedFrom(link: viewModel.imageURL, contentMode: .scaleToFill)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
}

struct SearchResultsViewModel {
    let imageURL: String
    let title: String
    let description: String
}
