//
//  AudioPlayerHelper.swift
//  MooWhoAVad
//
//  Created by Priyanka Joshi on 6/25/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayerHelper : NSObject, AVAudioPlayerDelegate {
    private var audioPlayer: AVAudioPlayer?
  
    func activateSoundForMuteMode() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch {
            // report for an error
            print("Error while trying to mark player as playback")
        }
    }

  /*  func checkForZeroVolume() {
        let deviceVolume = AVAudioSession.sharedInstance().outputVolume
        print(deviceVolume)
        if (deviceVolume == 0) {
            //TODO: Show volume switch
        }
    }*/
    
    func playSound(animalSound : String, numberOfLoops: Int){
     //   checkForZeroVolume()
        let path = Bundle.main.path(forResource: animalSound, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            if((audioPlayer != nil) && audioPlayer!.isPlaying) {
                audioPlayer!.stop()
            }
            //create your audioPlayer in your parent class as a property
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer!.delegate = self
            audioPlayer!.numberOfLoops = numberOfLoops
            DispatchQueue.global(qos: DispatchQoS.userInteractive.qosClass).async {
                 self.audioPlayer!.play()
            }
        } catch {
            print("couldn't load the file")
        }
    }
    
    //MARK: AVAudioPlayerDelegate methods
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //Show next view controller asking the user to identify which animal makes that sound
        player.stop()
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
