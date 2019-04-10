//
//  Play.swift
//  MooWho
//
//  Created by Priyanka Joshi on 4/9/19.
//  Copyright © 2019 Priyanka Joshi. All rights reserved.
//

import Foundation

struct Play {
    //Plays a random animal sound, and returqns the index of that animal
    static func playAnimalSound() -> (Int, [Int]) {
        let animals = Animals()
        let (animalIndex, animalArray) = animals.generateRandomAnimals(with: CircleLayout.NUM_OF_CANDIDATES)
        AudioPlayerHelper.shared.playSound(animalSound: animals.animalSound(for: animalIndex)!, numberOfLoops: 0)
        return (animalIndex, animalArray)
    }
}
