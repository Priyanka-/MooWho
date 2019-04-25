//
//  ExploreCollectionViewController.swift
//  MooWho
//
//  Created by Priyanka Joshi on 8/1/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "exploreCellReuseIdentifier"

class ExploreCollectionViewController: MooWhoCollectionViewController {

    let animals = Animals()

    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "exploreDetailSegue" else {
            return
        }
        if let controller = segue.destination as? AnimalDetailViewController, let animalIndex = (sender as? ExploreCollectionViewCell)?.animal?.1 {
            controller.chosenAnimalIndex = animalIndex
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.animalCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ExploreCollectionViewCell
        cell.animal = (animals[indexPath.row], indexPath.row)
        return cell
    }


    // MARK: UICollectionViewDelegate

    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   /* override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenAnimalIndex = indexPath.row
        self.performSegue(withIdentifier: "exploreDetailSegue", sender: self)
    }*/

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}

