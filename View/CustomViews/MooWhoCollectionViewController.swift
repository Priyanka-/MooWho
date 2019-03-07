//
//  PJCollectionViewController.swift
//  MooWho
//
//  Created by Priyanka Joshi on 7/31/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class MooWhoCollectionViewController: UICollectionViewController {

    var gradientLayer:CAGradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.colors =
            [GRADIENT_COLOR_TOP.cgColor,GRADIENT_COLOR_BOTTOM.cgColor]
        //Use different colors
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        collectionView?.contentInset = UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
    }
}
