//
//  MusicPlayer.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 20/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class MusicPlayer: NSObject {
    // Sound toggles
         static private var isNarratorOn = true;
         static private var isMusicOn = true;
    
    // AudioPlayer tracks
         static public var backgroundMusicTrack: AVAudioPlayer!;
         static private var buttonSoundEffectTrack: AVAudioPlayer!;
         static private var audioFileURL: URL?
    
    // General audio configuration items
        static private var session: AVAudioSession!;
    static public var isSetup = false;
    
    static func setup() {
        print("setup underway")
        // store the app's current audio configuration of the app for easy access
            session = AVAudioSession.sharedInstance()
        
        // set the current session to optimise the output of audio
            try! session.setCategory(AVAudioSessionCategoryPlayback)
        
        // Retrieve location of each track's music
            let BGMFileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Background prototype", ofType: "m4a")!)
            let buttonSFXFileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "hustle-on", ofType: "wav")!);
        
        do {
            // Store music data in variables
                backgroundMusicTrack = try AVAudioPlayer(contentsOf: BGMFileURL);
                buttonSoundEffectTrack = try AVAudioPlayer(contentsOf: buttonSFXFileURL);
            // Begin control of a shared audio session instance
                try session.setActive(true)
            
            // Track configuration
            buttonSoundEffectTrack.prepareToPlay()
            backgroundMusicTrack.numberOfLoops = -1;
            
        }
        catch {
            print(error)
        }
        isSetup = true;
        backgroundMusicTrack.play()
    }

    // toggleNarration:
    //                      change "isNarrationOn" to alternate boolean state
    
         static func toggleNarration()
         {
            if(isNarratorOn)
            {
                isNarratorOn = false;
            }
            else
            {
                isNarratorOn = true;
            }
        }
    
    // getNarrationState:
    //                      retrieve isNarrationOn, for the purpose of changing narrator-sound-button graphic to reflect
    //                      state
    
        static func getNarrationState() -> Bool {
            return isNarratorOn;
            
        }
    
    // toggleMusic:
    //                      change "isMusicOn" to alternate boolean state and oprimise session for change in setting
    
        static func toggleMusic()
        {
            if(isMusicOn)
            {
                isMusicOn = false;
                backgroundMusicTrack.stop();
            }
            else
            {
                isMusicOn = true;
                backgroundMusicTrack.play();
            }
            
            optimiseAudioSession()
        }
    
    // getMusicState:
    //                      retrieve isMusicOn, for the purpose of changing sound-button graphic to reflect state
         static func getMusicState() -> Bool {
            return isMusicOn;
            
        }
    
    // playSoundEffect:
    //                      After receiving a audioFileName, find the file reference in the Bundle and load the audioFile into the player
    //                      If there is an error, log it to the console window
        func playSoundEffect(audioFileName: String) {
            
        }
    
    static func playButtonSoundEffect() {
        buttonSoundEffectTrack.play()
    }
    
    // optimiseAudioSession:
    //                      If a form of music is playing, optimise session for playback, else set audio session for minimal sound
    static func optimiseAudioSession() {
        if(isMusicOn || isNarratorOn) {
            try! session.setCategory(AVAudioSessionCategoryPlayback)
        }
        else
        if( isMusicOn == false && isNarratorOn == false) {
            try! session.setCategory(AVAudioSessionCategoryAmbient)
        }
    }
}
