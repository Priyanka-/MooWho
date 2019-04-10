//
//  ViewController.swift
//  MooWho
//
//  Created by Priyanka Joshi on 6/25/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class PlayViewController: MooWhoViewController {

   
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func unwindToRootViewController(with segue:UIStoryboardSegue) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addPulseAnimationOnButton()
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AnimalIdentificationViewController {
            let (animalIndex, animalArray) = Play.playAnimalSound()
            controller.chosenAnimalIndex = animalIndex
            controller.randomArray = animalArray
        }
    }
    
    func addPulseAnimationOnButton() {
        UIView.animate(withDuration: TimeInterval(0.7), delay: TimeInterval(0), options: .allowUserInteraction, animations:{
            self.playButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },completion:{completion in
            UIView.animate(withDuration: TimeInterval(0.7), delay: TimeInterval(0), options: .allowUserInteraction, animations: { () -> Void in
                self.playButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    
    //MARK: Private methods

}

