//
//  TripsCollectionViewLayout.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/23/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation
import UIKit

class TripsCollectionViewLayout: UICollectionViewLayout {
    
    private static let dotViewHeight: CGFloat = 15
    private static let dotViewWidth: CGFloat = 7
    
    private static let verticalLineWidth: CGFloat = 2
    
    private static let cellVerticalMargin: CGFloat = 20
    private static let cellHorizontalMargin: CGFloat = 10
    private static let cellHeight: CGFloat = 280
    
    private var cellAttributes = [UICollectionViewLayoutAttributes]()
    private var verticalLineDecoratorViewAttributes = [UICollectionViewLayoutAttributes]()
    private var dotDecoratorViewAttributes = [UICollectionViewLayoutAttributes]()
    
    var dataModels: [TripsViewModel]? {
        didSet {
            invalidateLayout()
        }
    }
    
    override init() {
        super.init()
        //self.register(TripsVeritcalLineDecoratorView.self, forDecorationViewOfKind: TripsVeritcalLineDecoratorView.reusableViewIdentifier)
        self.register(TripsDotDecoratorView.self, forDecorationViewOfKind: TripsDotDecoratorView.reusableViewIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reloadLayoutAttributes() {
        cellAttributes = [UICollectionViewLayoutAttributes]()
        verticalLineDecoratorViewAttributes = [UICollectionViewLayoutAttributes]()
        dotDecoratorViewAttributes = [UICollectionViewLayoutAttributes]()
        
        guard let dataModels = dataModels, let collectionView = collectionView else { return }
        
        let cellVerticalMargin = TripsCollectionViewLayout.cellVerticalMargin
        let cellHorizontalMargin = TripsCollectionViewLayout.cellHorizontalMargin
        
        var maxCellY: CGFloat = cellVerticalMargin
        var maxDecoratorY: CGFloat = 0
        
        let dotViewHeight: CGFloat = TripsCollectionViewLayout.dotViewHeight
        let dotViewWidth: CGFloat = TripsCollectionViewLayout.dotViewWidth
        let dotViewMargin: CGFloat = 4.0
        
        for i in 0..<dataModels.count {
            let indexPath = IndexPath(item: i, section: 0)
            
            let verticalLineAttr = UICollectionViewLayoutAttributes(forDecorationViewOfKind: TripsVeritcalLineDecoratorView.reusableViewIdentifier, with: indexPath)
            let dotViewAttr = UICollectionViewLayoutAttributes(forDecorationViewOfKind: TripsDotDecoratorView.reusableViewIdentifier, with: indexPath)
            let cellAttr = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            verticalLineAttr.frame = CGRect(x: cellHorizontalMargin, y: maxDecoratorY, width: TripsCollectionViewLayout.verticalLineWidth, height: TripsCollectionViewLayout.cellHeight + (i == 0 ? cellVerticalMargin : 0))
            
            
            let cellWidth = collectionView.frame.width - 3 * cellVerticalMargin - verticalLineAttr.frame.width
            
            cellAttr.frame = CGRect(x: verticalLineAttr.frame.maxX + cellHorizontalMargin, y: maxCellY, width: cellWidth, height: TripsCollectionViewLayout.cellHeight)
            
            dotViewAttr.frame = CGRect(x: cellHorizontalMargin, y: maxCellY + dotViewMargin + TripsCollectionViewCell.titleLabelHeight, width: dotViewWidth, height: dotViewHeight)
            dotViewAttr.zIndex = 1
            
            maxCellY = cellAttr.frame.maxY + cellHorizontalMargin
            maxDecoratorY = maxCellY
            
            cellAttributes.append(cellAttr)
            //verticalLineDecoratorViewAttributes.append(verticalLineAttr)
            dotDecoratorViewAttributes.append(dotViewAttr)
        }
    }
    
    override func prepare() {
        super.prepare()
        reloadLayoutAttributes()
    }
    
    override var collectionViewContentSize: CGSize {
        guard let last = dotDecoratorViewAttributes.last, let view = collectionView else { return .zero }
        //let dotViewAttr =  dotDecoratorViewAttributes.last
        //+ 0.5 * dotViewAttr.frame.width
        return CGSize(width: view.frame.width - 2 * TripsCollectionViewLayout.cellVerticalMargin , height: last.frame.maxY)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = [UICollectionViewLayoutAttributes]()
        
        cellAttributes.enumerated().forEach { index, attr in
            if attr.frame.intersects(rect) {
                attrs.append(attr)
            }
        }
        
        verticalLineDecoratorViewAttributes.enumerated().forEach { index, attr in
            if attr.frame.intersects(rect) {
                attrs.append(attr)
            }
        }
        
        dotDecoratorViewAttributes.enumerated().forEach { index, attr in
            if attr.frame.intersects(rect) {
                attrs.append(attr)
            }
        }
        
        return attrs
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes[indexPath.item]
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == String(describing: TripsDotDecoratorView.self) {
            return dotDecoratorViewAttributes[indexPath.item]
        } else {
            return verticalLineDecoratorViewAttributes[indexPath.item]
        }
    }
}
