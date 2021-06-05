//
//  SounManager.swift
//  CardMatchingGame
//
//  Created by Abdul Dayur on 6/4/21.
//

import Foundation
import AVFoundation


class SoundManager {
    var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        case Flip
        case match
        case nomatch
        case shuffle
    }
    
    func playSound(effect: SoundEffect) {
         
        var soundFileName = ""
        
        switch effect {
        
            case .Flip:
                soundFileName = "cardflip"
            
            case .match:
                soundFileName = "dingcorrect"
                
            case .nomatch:
                soundFileName = "dingwrong"
                
            case .shuffle:
                soundFileName = "shuffle"
        }
        
        // Get the path to the resource
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
        
        // Check that its not nill
        guard bundlePath != nil else {return}
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Couldn't create an audio player")
            return
        }
        
    }
}
