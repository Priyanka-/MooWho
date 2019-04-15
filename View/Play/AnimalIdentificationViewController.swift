//
//  AnimalIdentificationViewController.swift
//  MooWho
//
//  Created by Priyanka Joshi on 6/25/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit
import AudioToolbox

class AnimalIdentificationViewController: MooWhoViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var chosenAnimalIndex : Int?
    var randomArray: [Int]?
    var wrongGuessIndices : [Int] = []
    @IBOutlet weak var collectionView: UICollectionView!
    let animals: Animals = Animals()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets.init(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
     //   collectionView.insetsLayoutMarginsFromSafeArea = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AnimalDetailViewController {
            controller.chosenAnimalIndex = chosenAnimalIndex!
        }
     //   if let navVCsCount = navigationController?.viewControllers.count {
       //     navigationController?.viewControllers.removeSubrange(Range(1..<navVCsCount - 1))
        //}
    }
    
   
    // MARK: UICollectionViewDataSource

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CircleLayout.NUM_OF_CANDIDATES
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animalCellReuseIdentifier", for: indexPath) as! AnimalCollectionViewCell

        let animalIndex = randomArray![indexPath.row]
        if let imageName = animals.croppedImageURL(forIndex: animalIndex) {
            cell.imageView.image = UIImage.init(named: imageName)
        }
        
        if (wrongGuessIndices.contains(indexPath.row)) {
            cell.isCrossedOut = true
        } else {
            cell.isCrossedOut = false
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
      func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
     }
    
    // Uncomment this method to specify if the specified item should be selected
     func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
     }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Was the right animal identified?
        if let cell = collectionView.cellForItem(at: indexPath) as? AnimalCollectionViewCell {
            let animalIndex = randomArray![indexPath.row]
            if (animalIndex == chosenAnimalIndex) {
                let confettiView = SAConfettiView(frame: self.view.bounds)
                self.view.addSubview(confettiView)
                confettiView.intensity = 0.75
                confettiView.startConfetti()
                AudioPlayerHelper.shared.playSound(animalSound: animals.animalSound(for: chosenAnimalIndex!)!, numberOfLoops: 0)

                self.view.isUserInteractionEnabled = false
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {_ in
                    self.performSegue(withIdentifier: "animalDetailSegue", sender: self)
                    confettiView.stopConfetti()
                })
            } else {
                //Oops, mark cell as crossed out
                wrongGuessIndices.append(indexPath.row)
                cell.isCrossedOut = true
                
                //try again wiggle and vibration
                self.addWiggleAnimationToCell(cell: cell)
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate), { [weak self] in
                    self?.replay(numberOfLoops: 0)
                })
             }
        }
    }

    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if (identifier == "animalDetailSegue") {
            super.performSegue(withIdentifier: identifier, sender: sender)
            self.navigationController?.viewControllers.remove(at: (self.navigationController?.viewControllers.firstIndex(of: self))!)
        }
    }
    
    //MARK:Private methods
    @IBAction func replayTapped(_ sender: Any) {
        replay(numberOfLoops: 0)
    }
    
    private func replay(numberOfLoops: Int) {
        AudioPlayerHelper.shared.playSound(animalSound: animals.animalSound(for: chosenAnimalIndex!)!, numberOfLoops: numberOfLoops)
    }
    
    //MARK: Wiggle animation when wrong cell is selected
    private func addWiggleAnimationToCell(cell: UICollectionViewCell) {
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        cell.layer.add(rotationAnimation(), forKey: "rotation")
        cell.layer.add(bounceAnimation(), forKey: "bounce")
        CATransaction.commit()
    }
    
    private func rotationAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        let angle = CGFloat(0.04)
        let duration = TimeInterval(0.1)
        let variance = Double(0.025)
        animation.values = [angle, -angle]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(interval: duration, withVariance: variance)
        animation.repeatCount = 3
        return animation
    }
    
    private func bounceAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        let bounce = CGFloat(3.0)
        let duration = TimeInterval(0.12)
        let variance = Double(0.025)
        animation.values = [bounce, -bounce]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(interval: duration, withVariance: variance)
        animation.repeatCount = 3
        return animation
    }
    
    private func randomizeInterval(interval: TimeInterval, withVariance variance:Double) -> TimeInterval {
        let random = Double.random(in: -1.0...1.0)
        return interval + variance * random;
    }
}
