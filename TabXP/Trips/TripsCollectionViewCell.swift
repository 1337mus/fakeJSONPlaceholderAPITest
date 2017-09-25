//
//  TripsCollectionViewCell.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/23/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import UIKit

class TripsCollectionViewCell: UICollectionViewCell {
    
    static let timestampLabelVerticalMargin: CGFloat = 5.0
    static let titleLabelHeight: CGFloat = 40
    
    private let titleLabel = UILabel()
    private let timestampLabel = UILabel()
    
    private let containerView = UIView()
    
    private let imageView = UIImageView()
    private let cityNameLabel = UILabel()
    private let addressLabel = UILabel()
    
    var viewModel = TripsViewModel(imageURL: "", cityName: "Oakland", address: "424 Orange St", timestamp: "2 years ago") {
        didSet {
            didSetViewModel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        setupTitleLabel()
        setupTimestampLabel()
        setupContainerView()
        setupImageView()
        setupCityNameLabel()
        setupAddressLabel()
        
        didSetViewModel()
    }
    
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        let font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium)
        
        titleLabel.heightAnchor.constraint(equalToConstant: TripsCollectionViewCell.titleLabelHeight).isActive = true
        titleLabel.font = font
        
        titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)
        titleLabel.textColor = UIColor.darkText
    }
    
    private func setupTimestampLabel() {
        contentView.addSubview(timestampLabel)
        
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timestampLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: TripsCollectionViewCell.timestampLabelVerticalMargin).isActive = true
        
        timestampLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        timestampLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        let font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        
        timestampLabel.heightAnchor.constraint(equalToConstant: font.pointSize).isActive = true
        timestampLabel.font = font
        
        timestampLabel.textColor = UIColor.darkGray
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: timestampLabel.bottomAnchor, constant: TripsCollectionViewCell.timestampLabelVerticalMargin).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        containerView.backgroundColor = UIColor.white
    }
    
    private func setupImageView() {
        containerView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 2/3, constant: 0).isActive = true
        
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setupCityNameLabel() {
        containerView.addSubview(cityNameLabel)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        cityNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        cityNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
        
        cityNameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        cityNameLabel.textColor = UIColor.darkGray
    }
    
    private func setupAddressLabel() {
        containerView.addSubview(addressLabel)
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
        addressLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        
        addressLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        addressLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)
        
        addressLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        
        addressLabel.numberOfLines = 0
        addressLabel.lineBreakMode = .byWordWrapping
    }
    
    private func didSetViewModel() {
        timestampLabel.text = viewModel.timestamp
        titleLabel.text = viewModel.cityName
        imageView.downloadedFrom(link: viewModel.imageURL, contentMode: .scaleToFill)
        cityNameLabel.text = viewModel.cityName
        addressLabel.text = viewModel.address
    }
}

struct TripsViewModel {
    let imageURL: String
    let cityName: String
    let address: String
    let timestamp: String
}
