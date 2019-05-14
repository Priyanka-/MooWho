//
//  MooWhoStorage.swift
//  MooWho
//
//  Created by Priyanka Joshi on 7/25/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import Foundation

struct Favorite : Comparable, Codable {
    var animalIndex:Int
    var favoriteScore:Int
    
    static func < (lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.favoriteScore > rhs.favoriteScore
    }
    
    init(index:Int, score:Int) {
        self.animalIndex = index
        self.favoriteScore = score
    }
}

/*
 * Saves pets in format where String key is index(as String, because UserDefaults mandates String) of the animal in AnimalMapping, and Int value is number of times it has been pet
 */
struct MooWhoStorage {
    
    static var shared = MooWhoStorage.init()
    
    private let favoritesKey = "favorites"
    private var favorites:[Favorite]
    
    private init() {
        favorites = []
        reload()
    }
    
    func getFavorites() -> [Favorite] {
        return favorites
    }
    
    mutating func reload() {
        let data = UserDefaults.standard.data(forKey: favoritesKey)
        if (data != nil) {
            let decoder = JSONDecoder.init()
            do {
                let favs = try decoder.decode([Favorite].self, from: data!)
                favorites = favs
                favorites.sort()
            } catch {
                print("caught \(error) while decoding Favorites from User Defaults")
            }
           
        } else {
            print("Fetched nil Favorites from User Defaults")
        }
    }
    
    func save() {
        let encoder = JSONEncoder.init()
        do {
            let data = try encoder.encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("caught \(error) while encoding Favorites for User Defaults")
        }
    }
    
    mutating func delete(atIndex: Int) {
        favorites.remove(at: atIndex)
        save()
    }
    
    mutating func add(favorite: Favorite) {
        favorites.append(favorite)
        favorites.sort()
        save()
    }
    
    mutating func replace(favorite:Favorite, at index:Int) {
        favorites[index] = favorite
        favorites.sort()
        save()
    }
    
}

