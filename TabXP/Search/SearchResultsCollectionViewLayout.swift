//
//  SearchResultsCollectionViewLayout.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/25/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import UIKit

class SearchResultsCollectionViewLayout: UICollectionViewLayout {
    
    let cellVerticalMargin: CGFloat = 25
    let cellHeight: CGFloat = 200
    
    var cellAttributes = [UICollectionViewLayoutAttributes]()
    
    var viewModels: [SearchResultsViewModel]? {
        didSet {
            invalidateLayout()
        }
    }
    
    private func reloadLayoutAttributes() {
        cellAttributes = []
        
        guard let collectionView = collectionView, let viewModels = viewModels else { return }
        
        let cellWidth = (collectionView.frame.width - 3 * cellVerticalMargin) / 2
        var maxY: CGFloat = cellVerticalMargin
        var nextX: CGFloat = cellVerticalMargin
        
        for i in 0..<viewModels.count {
            let indexPath = IndexPath(item: i, section: 0)
            let cellAttr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            cellAttr.frame = CGRect(x: nextX, y: maxY, width: cellWidth, height: cellHeight)
            
            if i % 2 == 0 {
                nextX = cellAttr.frame.maxX + cellVerticalMargin
            } else {
                nextX = cellVerticalMargin
                maxY = cellAttr.frame.maxY + cellVerticalMargin
            }
            
            cellAttributes.append(cellAttr)
        }
    }
    
    override func prepare() {
        super.prepare()
        reloadLayoutAttributes()
    }
    
    override var collectionViewContentSize: CGSize {
        guard let last = cellAttributes.last, let collectionView = collectionView  else { return .zero }
        
        return CGSize(width: collectionView.frame.width, height: last.frame.maxY)
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        
        cellAttributes.forEach {
            if $0.frame.intersects(rect) {
                attributes.append($0)
            }
        }
        
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes[indexPath.item]
    }
}
