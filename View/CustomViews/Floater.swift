/*The MIT License (MIT)

Copyright (c) 2015-2016 Razvigor Andreev

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

//
//  floater.swift
//  floaters
//
//  Created by Razvigor Andreev on 2/8/16.
//  Copyright © 2016 Razvigor Andreev. All rights reserved.
//

import UIKit

@IBDesignable public class Floater: UIView {
    
    
    var image1: UIImage?
    var image2: UIImage?
    var image3: UIImage?
    var image4: UIImage?
    
    var isAnimating: Bool = false
    var views: [UIView]!
    var duration: TimeInterval = 1.0
    var duration1: TimeInterval = 2.0
    var duration2: TimeInterval = 2.0
    var floatieSize = CGSize(width: 50, height: 50)
    var floatieDelay: Double = 10
    var delay: Double = 10.0
    var startingAlpha: CGFloat = 1.0
    var endingAlpha: CGFloat = 0.0
    var upwards: Bool = true
    var remove: Bool = true
    
    @IBInspectable var removeAtEnd: Bool = true {
        didSet {
            remove = removeAtEnd
        }
    }
    @IBInspectable var FloatingUp: Bool = true {
        didSet {
            upwards = FloatingUp
        }
    }
    @IBInspectable var alphaAtStart: CGFloat = 1.0 {
        didSet {
            startingAlpha = alphaAtStart
        }
    }
    @IBInspectable var alphaAtEnd: CGFloat = 0.0 {
        didSet {
            endingAlpha = alphaAtEnd
        }
    }
    @IBInspectable var rotationSpeed: Double = 10 {
        didSet {
            duration2 = 20 / rotationSpeed
        }
    }
    @IBInspectable var density: Double = 10 {
        didSet {
            floatieDelay = 1 / density
        }
    }
    @IBInspectable var delayedStart: Double = 10 {
        didSet {
            delay = delayedStart
        }
    }
    @IBInspectable var speedY: CGFloat = 10 {
        didSet {
            duration = Double(10/speedY)
        }
    }
    @IBInspectable var speedX: CGFloat = 5 {
        didSet {
            duration1 = Double(10/speedX)
        }
    }
    @IBInspectable var floatieWidth: CGFloat = 50 {
        didSet {
            floatieSize.width = floatieWidth
        }
    }
    @IBInspectable var floatieHeight: CGFloat = 50 {
        didSet {
            floatieSize.height = floatieHeight
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var floaterImage1: UIImage? {
        didSet {
            image1 = floaterImage1
        }
    }
    @IBInspectable var floaterImage2: UIImage? {
        didSet {
            image2 = floaterImage2
        }
    }
    @IBInspectable var floaterImage3: UIImage? {
        didSet {
            image3 = floaterImage3
        }
    }
    @IBInspectable var floaterImage4: UIImage? {
        didSet {
            image4 = floaterImage4
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func startAnimation() {
        
        if !isAnimating {
            isAnimating = true
            views = []
            var imagesArray = [UIImage?]()
            var actualImages = [UIImage]()
            let frameW = self.frame.width
            let frameH = self.frame.height
            var startingPoint: CGFloat!
            var endingPoint: CGFloat!
            if upwards {
                startingPoint = frameH
                endingPoint = floatieHeight*2
            } else {
                startingPoint = 0
                endingPoint = frameH - floatieHeight*2
            }
            imagesArray += [image1, image2, image3, image4]
            if !imagesArray.isEmpty {
                for i in imagesArray {
                    if i != nil {
                        actualImages.append(i!)
                    }
                }
            }
            
            DispatchQueue.global(qos: .background).async { [weak self] in
                var next = true
                while (self?.isAnimating ?? false) {
                    if next {
                        next = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + self!.floatieDelay) { [weak self] in
                            if let self = self {
                                let randomBool = Bool.random()
                                var randomRotation: CGFloat!
                                if randomBool {
                                    randomRotation = -1
                                } else {
                                    randomRotation = 1
                                }
                                let range = (self.floatieSize.width/2.0)...(self.frame.width - (self.floatieSize.width/2.0))
                                let randomX = CGFloat.random(in: range)
                                let floatieView = UIView(frame: CGRect(x: randomX, y: startingPoint, width: 50, height: 50))
                                self.addSubview(floatieView)
                                
                                let floatie = UIImageView(frame: CGRect(x: 0, y: 0, width: self.floatieSize.width, height: self.floatieSize.height))
                                
                                if !actualImages.isEmpty {
                                    
                                    let randomImageIndex = Int.random(in: 1..<actualImages.count)
                                    floatie.image = actualImages[randomImageIndex]
                                    floatie.center = CGPoint(x: 0, y: 0)
                                    floatie.backgroundColor = UIColor.clear
                                    floatie.layer.zPosition = 10
                                    floatie.alpha = self.startingAlpha
                                    
                                    floatieView.addSubview(floatie)
                                    var xChange: CGFloat!
                                    if randomX < self.frame.width/2 {
                                        xChange = randomX + CGFloat.random(in: randomX...frameW-randomX)
                                    } else {
                                        xChange = CGFloat.random(in: self.floatieSize.width*2...randomX)
                                    }
                                    self.views.append(floatieView)
                                    UIView.animate(withDuration: self.duration, delay: 0,
                                                   options: [], animations: {
                                                    floatieView.center.y = endingPoint
                                                    floatie.alpha = self.endingAlpha
                                                    next = true
                                    }, completion: {(value: Bool) in
                                        if self.remove {
                                            floatieView.removeFromSuperview()
                                        }
                                    })
                                    UIView.animate(withDuration: self.duration1, delay: 0,
                                                   options: [.repeat, .autoreverse], animations: {
                                                    floatieView.center.x = xChange
                                    }, completion: nil)
                                    UIView.animate(withDuration: self.duration2, delay: 0, options: [.repeat, .autoreverse], animations: {floatieView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2)*randomRotation)
                                    }, completion: nil)
                                    
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func stopAnimation() {
        isAnimating = false
        if !views.isEmpty {
            for i in views {
                i.removeFromSuperview()
            }
        }
        views = []
    }
    
}
