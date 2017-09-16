//
//  ExploreTableViewCell.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/15/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewDataSource = ExploreCollectionViewDataSource(experiences: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = collectionViewDataSource
    }
    
    var viewModel: ExploreCellViewModel? {
        didSet {
            didSetViewModel()
        }
    }
    
    func didSetViewModel() {
        if let vm = viewModel {
            collectionViewDataSource.experiences = vm.experiences
            collectionView.reloadData()
        }
    }
}
struct ExploreCellViewModel {
    let experiences: [Experience]
}

class ExploreCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var experiences: [Experience]
    
    init(experiences: [Experience]) {
        self.experiences = experiences
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return experiences.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let xp = experiences[indexPath.item]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ExploreCollectionViewCell.self), for: indexPath) as? ExploreCollectionViewCell {
            cell.experience = xp
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

}
