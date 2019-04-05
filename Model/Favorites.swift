//
//  Favorites.swift
//  MooWho
//
//  Created by Priyanka Joshi on 8/6/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import Foundation

struct Favorites {
    var isEmpty : Bool {
        return MooWhoStorage.shared.getFavorites().count == 0
    }
    
    var count: Int {
        return MooWhoStorage.shared.getFavorites().count
    }
    
    func next(after index: Int) -> Int? {
        let favorites = MooWhoStorage.shared.getFavorites()
        let position: Int? = find(animalIndex: index)
        if (position == nil || position == (favorites.count-1)) {
            return nil
        }
        return favorites[position! + 1].animalIndex
    }
    
    func delete(at index:Int) {
        let animalInd = animalIndex(for: index)
        MooWhoStorage.shared.delete(atIndex: animalInd)
    }
    
    func find(animalIndex:Int) -> Int? {
        return MooWhoStorage.shared.getFavorites().firstIndex(where: {$0.animalIndex == animalIndex})
    }
    
    func isFavorite(index: Int) -> Bool {
        let fav = find(animalIndex:index)
        return fav != nil
    }
    
    func animalIndex(for index: Int) -> Int {
        return MooWhoStorage.shared.getFavorites()[index].animalIndex
    }
    
    func incrementFavoriteScore(of animalIndex:Int) -> Bool{
        let favIndex = find(animalIndex: animalIndex)
        let isFav = (favIndex != nil)
        if (favIndex == nil) {
            let favorite = Favorite.init(index: animalIndex, score: 1)
            MooWhoStorage.shared.add(favorite: favorite)
        } else {
            var favorite = MooWhoStorage.shared.getFavorites()[favIndex!]
            favorite.favoriteScore += 1
            MooWhoStorage.shared.replace(favorite:favorite, at:favIndex!)
        }
        return isFav
    }
    
}
