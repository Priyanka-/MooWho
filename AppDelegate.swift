//
//  AppDelegate.swift
//  MooWho
//
//  Created by Priyanka Joshi on 6/25/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var audioPlayerHelper : AudioPlayerHelper!
    var appInBackground:Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      //  window?.tintColor = UIColor.cyan
        
        audioPlayerHelper = AudioPlayerHelper.init()
        audioPlayerHelper.activateSoundForMuteMode()
 
        if let customFont = UIFont(name: CUSTOM_FONT, size: UIFont.labelFontSize) {
            UILabel.appearance().font = customFont
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: CUSTOM_FONT, size: 20)!]
            if #available(iOS 11.0, *) {
                UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: CUSTOM_FONT, size: 30)!]
            } else {
                // Fallback on earlier versions
            }
            
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: CUSTOM_FONT, size: 20)!], for: UIControl.State.normal)
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: CUSTOM_FONT, size: 20)!], for: UIControl.State.disabled)
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: CUSTOM_FONT, size: 20)!], for: UIControl.State.highlighted)
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: CUSTOM_FONT, size: 20)!], for: UIControl.State.focused)
        } else {
            print("""
Failed to load the "NORTHWEST" font. Make sure the font file is included in the project and the font name is spelled correctly.
"""
            )
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        appInBackground = true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        appInBackground = false
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK: Audio
    
    //Plays a random animal sound, and returns the index of that animal
    func playAnimalSound() -> (Int, [Int]) {
        let (animalIndex, animalArray) = generateRandomAnimals(with: CircleLayout.NUM_OF_CANDIDATES)
        audioPlayerHelper.playSound(animalSound: animalSound(for: animalIndex)!, numberOfLoops: 0)
        return (animalIndex, animalArray)
    }

}

