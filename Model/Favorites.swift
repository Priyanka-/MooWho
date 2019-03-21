//
//  Favorites.swift
//  MooWho
//
//  Created by Priyanka Joshi on 8/6/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import Foundation

class Favorites : NSObject {
    private var favorites : [(String,Int)] = [] //Tuple of favorites, sorted by most petted. Key is index of animal, and value is number of times petted.
    
    func reload() {
        let favs = MooWhoUserDefaultsManager.getFavorites()
        favorites = favs.valueKeySorted
    }
    
    func numberOfFavorites() -> Int {
        return favorites.count
    }
    
    func nextFavoriteAnimalIndex(for index: Int) -> Int? {
        let position: Int? = favorites.index(where: {Int($0.0) == index})
        if(position == nil || position == (favorites.count-1)) {
            return nil
        }
        return Int(favorites[favorites.index(after:position!)].0)
    }
    
    func deleteFavorite(at index:Int) {
        var favs = MooWhoUserDefaultsManager.getFavorites()
        let animalIndex = mapFavoriteIndexToActualIndex(for: index)
        favs.removeValue(forKey: String(animalIndex))
        MooWhoUserDefaultsManager.setFavorites(favs: favs)
        reload()
    }
    
    func mapFavoriteIndexToActualIndex(for index: Int) -> Int {
        return Int(favorites[index].0)!
    }
    
}
