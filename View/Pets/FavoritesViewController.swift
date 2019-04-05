//
//  FavoritesViewController.swift
//  MooWho
//
//  Created by Priyanka Joshi on 7/30/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class FavoritesViewController: MooWhoCollectionViewController {
    
    var selectedFavorite : Int = -1
    let favoritesModel : Favorites = Favorites.init()
    let animals:Animals = Animals()
    
    override func viewDidLoad() {
        let deleteMenuItem = UIMenuItem(title: "Remove", action: NSSelectorFromString("deleteCollection"))
        UIMenuController.shared.menuItems = [deleteMenuItem]
        setupNoFavsView()
        super.viewDidLoad()
    }
    
    func setupNoFavsView() {
        let noFavsLabel = PaddingLabel.init()
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = UIImage(named:"favorite")
        //Set bound to reposition
        let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: "Add pets to see here")
        completeText.append(textAfterIcon)
        noFavsLabel.textAlignment = .center;
        noFavsLabel.attributedText = completeText;
        noFavsLabel.font = UIFont(name: CUSTOM_FONT, size: UIFont.labelFontSize)
        collectionView?.backgroundView = noFavsLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView?.reloadData()
        collectionView?.backgroundView?.isHidden = !favoritesModel.isEmpty
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favReuseIdentifier", for: indexPath) as! FavoritesCollectionViewCell
      //  cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        let animalIndex = favoritesModel.animalIndex(for: indexPath.row)
        let imagePath = animals.croppedImageURL(forIndex: animalIndex)
        cell.imageView?.image = UIImage.init(named: imagePath!)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFavorite = favoritesModel.animalIndex(for: indexPath.row)
        self.performSegue(withIdentifier: "viewFavoriteSegue", sender: self)
    }
    
    
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == NSSelectorFromString("deleteCollection")
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        if (action == NSSelectorFromString("deleteCollection")) {
            favoritesModel.delete(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            collectionView.backgroundView?.isHidden = !favoritesModel.isEmpty
        }
     }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AnimalDetailViewController {
            controller.chosenAnimalIndex = selectedFavorite
            controller.favorites = favoritesModel
        }
    }
    
}

extension Dictionary where Value: Comparable {
    var valueKeySorted: [(Key, Value)] {
        return sorted{  return $0.value > $1.value }
    }
}
