//
//  AnimalCollectionViewCell.swift
//  MooWho
//
//  Created by Priyanka Joshi on 6/26/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class AnimalCollectionViewCell: MooWhoCollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var isCrossedOut: Bool = false {
        didSet {
            contentView.alpha = self.isCrossedOut ? 0.5 : 1
            isUserInteractionEnabled = !self.isCrossedOut
        }
    }
    
    override func cellBorderColor() -> CGColor {
        return UIColor.white.cgColor
    }
   
}
