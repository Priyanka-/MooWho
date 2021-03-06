//
//  Animal.swift
//  MooWho
//
//  Created by Priyanka Joshi on 6/25/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import Foundation

struct Animal {
    let name : String
    let sound : String
    let childName : String
}

extension Animal {
    func croppedImageName() -> String {
        return name + "Crop"
    }
    
    func childImageName() -> String {
        return name + childName
    }
}

private let dog = Animal(name: "Dog", sound : "dogbark.m4a", childName: "Puppy")
private let cat = Animal(name: "Cat", sound : "catmeow.m4a", childName: "Kitten")
private let frog = Animal(name: "Frog", sound : "frogcroak.m4a", childName: "Tadpole")
private let duck = Animal(name: "Duck", sound : "duckquack.m4a", childName: "Duckling")
private let lion = Animal(name: "Lion", sound : "lionroar.m4a", childName: "Cub")
private let pig = Animal(name: "Pig", sound : "piggrunt.m4a", childName: "Piglet")
private let elephant = Animal(name: "Elephant", sound : "trumpet.m4a", childName: "Calf")
private let goat = Animal(name: "Goat", sound : "goat.m4a", childName: "Kid")
private let sheep = Animal(name: "Sheep", sound : "sheep.m4a", childName: "Lamb")
private let horse = Animal(name: "Horse", sound : "horseneigh.m4a", childName: "Foal")
private let rooster = Animal(name: "Rooster", sound : "roostercrowing.m4a", childName: "Chick")
private let owl = Animal(name: "Owl", sound : "Owl.m4a", childName: "Owlet")
private let cow = Animal(name: "Cow", sound : "cow.m4a", childName: "Calf")
private let mouse = Animal(name: "Mouse", sound : "mousesqueak.m4a", childName: "Pup")
private let monkey = Animal(name: "Monkey", sound : "monkey.m4a", childName: "Infant")
private let donkey = Animal(name: "Donkey", sound : "donkeybraying.m4a", childName: "Foal")

struct Animals {
    private let animals = [dog, cat, frog, duck, cow, lion, pig, elephant, goat, sheep, horse, rooster, owl, mouse, monkey, donkey]
}

extension Animals {
/*
 Returns a tuple containing a random index and an array of random indices. The random index is at a random position in the random array
 */
func generateRandomAnimals(with count: Int) -> (Int, [Int]) {
    var randomArray: [Int] = [Int]()
    var n = 0
    var randomIndex: Int = 0
    let chosenPosition: Int = Int.random(in: 0..<count)
    var chosenIndex: Int = 0
    
    while (n < count) {
        randomIndex = Int.random(in: 0..<animals.count)
        if (!randomArray.contains(randomIndex)) {
            randomArray.append(randomIndex)
            if (n==chosenPosition) {
                chosenIndex = randomIndex
            }
            n = n + 1
        }
    }
    return (chosenIndex, randomArray)
}

func isValidIndex(index: Int?) -> Bool {
    return (index != nil && index! < animals.count && index! >= 0)
}

func animalCount() -> Int {
    return animals.count
}
   
subscript(index: Int) -> Animal {
    guard isValidIndex(index: index) else {
        fatalError("Working with invalid index of animal: \(index)")
    }
    return animals[index]
}
    
}

