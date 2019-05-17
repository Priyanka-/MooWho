//
//  HeartBubblesScene.swift
//  MooWho
//
//  Created by Priyanka Joshi on 5/17/19.
//  Copyright © 2019 Priyanka Joshi. All rights reserved.
//

import UIKit
import SpriteKit

let heartsFile = "heart-bubbles.sks"//particle file
let heartHeight: CGFloat = 60.0

class HeartBubblesScene : SKScene {
    var emitter: SKEmitterNode?
    
    override func sceneDidLoad() {
        scaleMode = .resizeFill // make scene's size == view's size
        backgroundColor = UIColor.clear
    }
    
    func beginBubbling() {
        
        emitter = SKEmitterNode(fileNamed: heartsFile)
        let x = floor(size.width / 2.0)
        let y = floor(size.height / 2.0)
        
        emitter!.position = CGPoint.init(x:x,y: y)
        
        emitter!.name = "heart-bubbles"
        emitter!.targetNode = self
        
        emitter?.numParticlesToEmit = 25
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            emitter?.particleScale = 2.0
        }
        
        addChild(emitter!)
        
        emitter?.resetSimulation()
    }
}
