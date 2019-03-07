//
//  PJViewController.swift
//  MooWho
//
//  Created by Priyanka Joshi on 7/25/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class MooWhoViewController: UIViewController {

    var gradientLayer:CAGradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.colors =
            [GRADIENT_COLOR_TOP.cgColor,GRADIENT_COLOR_BOTTOM.cgColor]
        //Use different colors
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
   /* override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        view.layoutSubviews()
    }
*/
}
