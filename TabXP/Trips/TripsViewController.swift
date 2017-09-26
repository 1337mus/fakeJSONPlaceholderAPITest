//
//  TripsViewController.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/14/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: TripsCollectionViewLayout())
    let dataLoader = TripsDataLoader()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = .zero
        collectionView.scrollIndicatorInsets = .zero
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        collectionView.dataSource = self
        
        collectionView.register(TripsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TripsCollectionViewCell.self))
        collectionView.register(TripsCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: TripsCollectionHeaderView.self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataLoader.reloadData { [weak self] success in
            guard let strongSelf = self, success else {
                return
            }
            
            if let layout = strongSelf.collectionView.collectionViewLayout as? TripsCollectionViewLayout {
                layout.dataModels = strongSelf.dataLoader.dataModels
            }
            strongSelf.collectionView.reloadData()
        }
    }
}

extension TripsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataLoader.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataLoader.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = dataLoader.item(at: indexPath)
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TripsCollectionViewCell.self), for: indexPath) as? TripsCollectionViewCell {
            cell.viewModel = viewModel
            return cell
        }
        return UICollectionViewCell()
    }
}

