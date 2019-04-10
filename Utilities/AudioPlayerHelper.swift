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
    
    private var state:State
    
    static var shared = AudioPlayerHelper.init()
    
    private override init() {
        state = .idle
        super.init()
        configure()
    }
  
    func configure() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch {
            // report for an error
            print("Error while trying to mark player as playback")
        }
    }
    
    func playSound(animalSound : String, numberOfLoops: Int){
     //   checkForZeroVolume()
        let path = Bundle.main.path(forResource: animalSound, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            switch state {
                case .playing(let player) :
                    player.stop()
                default: break
            }
            //create your audioPlayer in your parent class as a property
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.numberOfLoops = numberOfLoops
            DispatchQueue.global(qos: DispatchQoS.userInteractive.qosClass).async {
                audioPlayer.play()
            }
            state = .playing(audioPlayer)
        } catch {
            print("couldn't load the file: \(error.localizedDescription)")
        }
    }
    
    //MARK: AVAudioPlayerDelegate methods
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        switch state {
        case .playing(let audioPlayer) :
            if (audioPlayer == player) {
                state = .idle
            }
        default: break
        }
    }
}

extension AudioPlayerHelper {
    enum State {
        case idle
        case playing(AVAudioPlayer)
    }
}
