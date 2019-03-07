//
//  MooWhoFlowLayout.swift
//  MooWho
//
//  Created by Priyanka Joshi on 8/13/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class MooWhoFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        guard let collView = collectionView else {return}
        let size = collView.bounds.inset(by: collView.layoutMargins).size //collView.bounds.inset(by: collView.layoutMargins).size
        
        let numberOfItemsPerRow:CGFloat = 3.0
        let sectionInsets:CGFloat = 10.0
        let spacingBetweenItems = (numberOfItemsPerRow - 1) * sectionInsets + (2 * sectionInsets)
        let dimension = (size.width - spacingBetweenItems)/numberOfItemsPerRow - 2.0
        itemSize = CGSize(width: dimension,
                      height: dimension)
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var  layoutAttributes = super.layoutAttributesForItem(at: indexPath)
        if (layoutAttributes == nil) {
            layoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        }
        layoutAttributes?.size = itemSize
        return layoutAttributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collView = collectionView else {return nil}
        if (collView.numberOfItems(inSection: 0) < 1) {
            return nil
        }
        var attributes:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes].init()
        for n in 0...(collView.numberOfItems(inSection: 0) - 1) {
            attributes.append(layoutAttributesForItem(at: IndexPath.init(row: n, section: 0))!)
        }
        return attributes
    }
    
}
