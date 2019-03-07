//
//  PJUserDefaultsManager.swift
//  MooWho
//
//  Created by Priyanka Joshi on 7/25/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import Foundation
/*
 * Saves pets in format where String key is index(as String, because UserDefaults mandates String) of the animal in AnimalMapping, and Int value is number of times it has been pet
 */
class MooWhoUserDefaultsManager {
    
    private static let favoritesKey = "favoritesKey"
    
    static func getFavorites() -> [String : Int] {
        let favs = UserDefaults.standard.dictionary(forKey: favoritesKey)
        if (favs == nil) {
            return [ : ]
        } else {
            return favs! as! [String : Int]
        }
    }
    
    static func setFavorites(favs: [String: Int]?) {
        UserDefaults.standard.set(favs, forKey: favoritesKey)
    }
    
    static func isFavorite(index: Int) -> Bool {
        var favorites = getFavorites()
        return favorites[String(index)] != nil
    }
    
    static func incrementFavoriteScore(of index:Int) -> Bool{
        var favorites = getFavorites()
        let isFav = isFavorite(index: index)
        //Flip the favorite status
        if (isFav) {
            favorites[String(index)] =  1 + favorites[String(index)]!
        } else {
            favorites[String(index)] = 1
        }
        
        setFavorites(favs: favorites)
        return isFav
    }
}

