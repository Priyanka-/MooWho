//
//  ExploreCollectionViewCell.swift
//  MooWho
//
//  Created by Priyanka Joshi on 8/1/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class ExploreCollectionViewCell: MooWhoCollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func cellBorderColor() -> CGColor {
        return UIColor.brown.cgColor
    }

    var animal:(Animal, Int)? {
        didSet {
            if let _ = animal {
                imageView.image = UIImage.init(named: animal!.0.croppedImageName())
            } else {
                imageView.image = nil
            }
        }
    }
    
    override func prepareForReuse() {
        animal = nil
    }
}
