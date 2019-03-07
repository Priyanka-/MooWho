//
//  MooWhoCollectionViewCell.swift
//  MooWho
//
//  Created by Priyanka Joshi on 7/31/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class MooWhoCollectionViewCell: UICollectionViewCell {
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = CGFloat(roundf(Float(self.bounds.size.width / 2.0)))
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = cellBorderColor()
        self.layer.borderWidth = 5
    }
  
    func cellBorderColor() -> CGColor{
        preconditionFailure("This method must be overridden")
    }

}
