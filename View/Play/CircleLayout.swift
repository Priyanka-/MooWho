//
//  CircleLayout.swift
//  MooWho
//
//  Created by Priyanka Joshi on 8/8/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit
import Foundation

class CircleLayout: UICollectionViewLayout {
    var center: CGPoint?
    var radius: CGFloat?
  //  var cellCount: Int? // Really an Int
    var circumference: CGFloat?
    var itemSize: CGFloat?
    public static let NUM_OF_CANDIDATES = 7
    
    override func prepare() {
        super.prepare()
        guard let collView = collectionView else {return}
        let size = collView.bounds.inset(by: collView.layoutMargins).size //collView.bounds.inset(by: collView.layoutMargins).size
       
        center = CGPoint.init(x: collView.bounds.midX, y: collView.bounds.midY)
        radius = min(size.width, size.height)/2.5
        circumference = 2 * CGFloat.pi * radius!
        itemSize = ((4 * radius!)/(CGFloat)(CircleLayout.NUM_OF_CANDIDATES)).rounded()
        //(circumference!/(CGFloat)(cellCount!)).rounded() - 20 //Diameter of item
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            guard let collView = collectionView else {return CGSize.init(width: 0, height: 0)}
            return collView.bounds.inset(by: collView.layoutMargins).size
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var  layoutAttributes = super.layoutAttributesForItem(at: indexPath)
        if (layoutAttributes == nil) {
            layoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        }
        layoutAttributes?.size = CGSize(width: itemSize!,
                      height: itemSize!)
        let xPosition = (center?.x)! + radius! * (CGFloat)(cosf(Float(2 * (CGFloat)(indexPath.row) * CGFloat.pi/(CGFloat)(CircleLayout.NUM_OF_CANDIDATES))))
        let yPosition = (center?.y)! + radius! * (CGFloat)(sinf(Float(2 * (CGFloat)(indexPath.row) * CGFloat.pi/(CGFloat)(CircleLayout.NUM_OF_CANDIDATES))))
        layoutAttributes?.center = CGPoint.init(x: xPosition, y: yPosition)
        return layoutAttributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes].init()
        for n in 0...(CircleLayout.NUM_OF_CANDIDATES-1) {
            attributes.append(layoutAttributesForItem(at: IndexPath.init(row: n, section: 0))!)
        }
        return attributes
    }
}
