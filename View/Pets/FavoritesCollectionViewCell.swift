//
//  FavoritesCollectionViewCell.swift
//  MooWho
//
//  Created by Priyanka Joshi on 7/30/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: MooWhoCollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    //Provides the border color
    override func cellBorderColor() -> CGColor {
        return UIColor.red.cgColor
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == NSSelectorFromString("deleteCollection")
    }

    @objc func deleteCollection()
    {
        let collectionView = self.superview as! UICollectionView
        let d = collectionView.delegate
        d?.collectionView!(collectionView, performAction: NSSelectorFromString("deleteCollection"), forItemAt: collectionView.indexPath(for: self)!, withSender: self)        
    }
}
