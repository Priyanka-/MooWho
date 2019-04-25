//
//  AnimalDetailViewController.swift
//  MooWho
//
//  Created by Priyanka Joshi on 7/26/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
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

class AnimalDetailViewController: MooWhoViewController {

    let heartBubblesScene = HeartBubblesScene()

    @IBOutlet weak var heartsView: SKView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var playAnimalSoundButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var containerViewForImages: UIView!
    @IBOutlet weak var secondaryImageView: UIImageView!
    
    // Set these variables while segueing from another view controller
    var chosenAnimalIndex : Int = -1
    
    var favorites = Favorites.init()
    let animals = Animals.init()
    
    
    enum navigationContext : Int {
        case play = 0, favorite, explore
    }
    var tabIndex: navigationContext = .play
    
    var showingAnimalChild: Bool = false {
        didSet {
            if (showingAnimalChild == true) {
                self.title = animals[chosenAnimalIndex].childName
            } else {
                self.title = animals[chosenAnimalIndex].name
            }
        }
    }
    
    let LEFT_SWIPE_GESTURE_SEGUE_ID = "leftSwipeGestureSegue"
    let RIGHT_SWIPE_GESTURE_SEGUE_ID = "rightSwipeGestureSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.containerViewForImages.bringSubviewToFront(heartsView)
        heartsView.presentScene(heartBubblesScene)
        heartsView.allowsTransparency = true

        self.containerViewForImages.bringSubviewToFront(heartsView)
        
        tabIndex = navigationContext(rawValue: (self.navigationController?.tabBarController?.selectedIndex)!)!
        
        assert(animals.isValidIndex(index: chosenAnimalIndex))
        
        showingAnimalChild = false
    
        if (tabIndex != .play) {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(flipImages))
        singleTap.numberOfTapsRequired = 1
        containerViewForImages.addGestureRecognizer(singleTap)
        
        let image = UIImage.init(named: animals[chosenAnimalIndex].croppedImageName())
        mainImageView.image = image
        mainImageView.layer.borderWidth = 10
        
        let secondaryImage = UIImage.init(named: animals[chosenAnimalIndex].childImageName())
        secondaryImageView.image = secondaryImage
        secondaryImageView.layer.borderWidth = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFavoriteUI(isFavorite: favorites.isFavorite(index: chosenAnimalIndex))
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        heartBubblesScene.beginBubbling()

        if (!favorites.incrementFavoriteScore(of: chosenAnimalIndex)) {
            setFavoriteUI(isFavorite: true)
        }
    }
    
    
    @IBAction func playAnimalSoundButtonTapped(_ sender: Any) {
        AudioPlayerHelper.shared.playSound(animalSound: animals[chosenAnimalIndex].sound, numberOfLoops: 0)
    }
    
    
    @IBAction func rightSwipeGestureRecognized(_ sender: Any) {
        switch tabIndex {
        case .play:
            handlePlayTabRightSwipe()
            break
        case .favorite:
            handleFavsTabRightSwipe()
            break
        case .explore:
            handleExploreTabRightSwipe()
        }
    }
    
    @IBAction func leftSwipeGestureRecognized(_ sender: Any) {
        switch tabIndex {
        case .play:
            handlePlayTabLeftSwipe()
            break
        case .favorite:
            handleFavsTabLeftSwipe()
            break
        case .explore:
            handleExploreTabLeftSwipe()
        }
    }
    
    //MARK: Private methods
    func handleExploreTabRightSwipe() {
        goToDetailPage(with: chosenAnimalIndex + 1)
    }
    
    func handleExploreTabLeftSwipe() {
        navigationController?.popViewController(animated: true)
    }
    
    func handleFavsTabRightSwipe() {
        goToDetailPage(with: favorites.next(after: chosenAnimalIndex))
    }
    
    func handleFavsTabLeftSwipe() {
        navigationController?.popViewController(animated: true)
    }
    
    func handlePlayTabRightSwipe() {
        let nextChooserVC:AnimalIdentificationViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "animalChooserViewControllerStoryboardID")
            as! AnimalIdentificationViewController
        let (animalIndex, animalArray) = Play.playAnimalSound()
        nextChooserVC.chosenAnimalIndex = animalIndex
        nextChooserVC.randomArray = animalArray
        self.navigationController!.pushViewController(nextChooserVC, animated: true)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        handlePlayTabRightSwipe()
    }
   
    func handlePlayTabLeftSwipe() {
        //Initiate unwind segue
        performSegue(withIdentifier: "unwindToPlayViewController", sender: self)
    }
    
    func goToDetailPage(with index: Int?) {
        if (animals.isValidIndex(index: index)) {
            let nextDetailPage:AnimalDetailViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "detailPageStoryboardID")
                as! AnimalDetailViewController
            nextDetailPage.chosenAnimalIndex = index!
            self.navigationController!.pushViewController(nextDetailPage, animated: true)
        }
    }
    
    func setFavoriteUI(isFavorite: Bool) {
        if (isFavorite) {
            mainImageView.layer.borderColor = UIColor.red.cgColor
            secondaryImageView.layer.borderColor = UIColor.red.cgColor
        } else {
            mainImageView.layer.borderColor = UIColor.gray.cgColor
            secondaryImageView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @objc func flipImages() {
        let toView = showingAnimalChild ? mainImageView : secondaryImageView
        let fromView = showingAnimalChild ? secondaryImageView : mainImageView
       
        let transitionOptions : UIView.AnimationOptions = showingAnimalChild ? [.transitionFlipFromLeft, .showHideTransitionViews] : [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: containerViewForImages!, duration: 1.0, options: transitionOptions, animations: {
            toView!.isHidden = false
            fromView!.isHidden = true
        })
        
        showingAnimalChild = !showingAnimalChild
    }

}
