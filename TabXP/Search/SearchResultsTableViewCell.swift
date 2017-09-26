//
//  SearchResultsTableViewCell.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/25/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SearchResultsCollectionViewLayout())
    var collectionViewDataSource = SearchResultsCollectionViewDataSource(viewModels: [])
    
    var experiences = [Experience]() {
        didSet {
            didSetViewModel()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.lightGray 
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        collectionView.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SearchResultsCollectionViewCell.self))
        
        collectionView.dataSource = collectionViewDataSource
    }
    
    private func didSetViewModel() {
        let searchResultsViewModels = experiences.flatMap {
            SearchResultsViewModel(imageURL: $0.url, title: String.generateRandomStringWithLength(length: 20), description: $0.title)
        }
        
        if let layout = collectionView.collectionViewLayout as? SearchResultsCollectionViewLayout {
            layout.viewModels = searchResultsViewModels
        }
        
        collectionViewDataSource.viewModels = searchResultsViewModels
        collectionView.reloadData()
    }
}


class SearchResultsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var viewModels: [SearchResultsViewModel]
    
    init(viewModels: [SearchResultsViewModel]) {
        self.viewModels = viewModels
        super.init()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vm = viewModels[indexPath.item]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchResultsCollectionViewCell.self), for: indexPath) as? SearchResultsCollectionViewCell {
            cell.viewModel = vm
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

