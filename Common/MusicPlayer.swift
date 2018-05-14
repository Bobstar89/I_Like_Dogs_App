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

    /*
                                  ===================
                                      MUSICPLAYER
                                  ===================
 
                    Utilising the operation system's audio setting
                    and the AVAudioPlayer class, the MusicPlayer
                    is a static class used throughout the app.
 
                    Each sound is loaded into 'Music Player' via
                    seperate tracks for each of the Background Music,
                    Sound Effects and Narration audio files.
    */
class MusicPlayer: NSObject {
    
    /*  Name: isNarratirOn
     
        Description: stores whether or not to have narrator's voice speak while reading on screen text
     
        Used by: toggleNarration(), getNarration(), optimiseAudioSession()
     */
         static private var isNarratorOn = true;
    
    /*  Name: isMusicOn
     
        Description: stores whether or not to have narrator's voice speak while reading on screen text
     
        Used by: toggleMusic(), getMusic()
     */
        static private var isMusicOn = true;
    
    /*  Name: audioFileURL
     
        Description: stores an audio file's location as a URL object to be used for an AVAudioPlayer track
     
        Used by: setup(), loadPageTracks()
    */
    
        static private var audioFileURL: URL!
    
    /*  Name: soundtracks
     
        Description: stores each soundtrack name
     
        Used by: loadSoundtracksIntoStack()
 
     */
        static private var soundtracks = ["backgroundMusic", "nav-back", "nav-forward"]
    
    /*  Name: stack
     
        Description: stores audio references for sounds effects and music in a stack of tracks
     
        Used by: setup()

     */
        static private var stack = [String : AVAudioPlayer]();
    
        static private let numOfPageNarrationTracks = 7
    
    /*  session
 
        Description: stores the global operating system's audio setting
     
        Used by: setup()
    */
        static private var session: AVAudioSession!;
    
    /*  isSetup()
 
        Used by: setup()
     */
    static public var isSetup = false;
    
    /*  retrieveAudioFile()
     
        Dependencies: NONE
     
        Purpose: given a fileName and fileType, retrieveAudioFile() returns an absolute URL "path" to the caller
     */
    
    static func retrieveAudioFile(fileName: String, fileType: String) -> URL{
        
        // path is unchangeable and stores the absolute audio location
        let path = Bundle.main.path(forResource: fileName, ofType: fileType)!
        print(path);
        
        // return the location as a URL() object
        return URL(fileURLWithPath: path);
    }
    
    /*  setup()
     
        Dependencies: session, audioFileURL, backgroundSoundEffectTrack, buttonSoundEffectTrack
     
        Purpose: configure music session information and retrieve app sound effects
    */
    static func setup() {
        // Retrieve location of the background music file and store it in "audioFileURL"
            audioFileURL = retrieveAudioFile(fileName: "background", fileType: "mp3")
            stack["backgroundMusic"] = try! AVAudioPlayer(contentsOf: audioFileURL);
        
        // Retrieve location of the button sound effect file and store it in "audioFileURL"
            audioFileURL = retrieveAudioFile(fileName: "hustle-on", fileType: "wav")
           stack["buttonSoundEffect"] = try! AVAudioPlayer(contentsOf: audioFileURL);

        // store the app's current audio configuration of the app for easy access
        session = AVAudioSession.sharedInstance()
        
        // set the current session to optimise the output of audio
        try! session.setCategory(AVAudioSessionCategoryPlayback)

        // Begin control of a shared audio session instance
        try! session.setActive(true)
            
        // preload button effect sound
        stack["buttonSoundEffect"]!.prepareToPlay()
        
        // repeat background track indefinitely
        stack["backgroundMusic"]!.numberOfLoops = -1;
        stack["backgroundMusic"]!.play()
        
//        for i in 0...numOfPageNarrationTracks {
//            loadPageTracks(pageNumber: i);
//        }
        /*  setup complete in "Main Menu"
 
            Used by: MainMenuController.viewDidLoad()
        */
            isSetup = true;
        
    }
    
    static func loadsoundtracksIntoMusicStack(pageNumber: Int){
        for i in 0...soundtracks.count {
            audioFileURL = retrieveAudioFile(fileName: soundtracks[i], fileType: "mp3");
            do {
                let track = try AVAudioPlayer(contentsOf: audioFileURL)
                stack["\(soundtracks[i])"] = track;
            }
            catch { print(error) }
        }
    }
    
    /*  toggleNarration()
     
        Dependencies: isNarrationOn
     
        Description: change "isNarrationOn" to alternate state
 
    */
         static func toggleNarration()
         {
            if(isNarratorOn)
            {
                // Turn narration off
                    isNarratorOn = false;
            }
            else
            {
                // Turn narration on
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
                stack["backgroundMusic"]!.stop();
            }
            else
            {
                isMusicOn = true;
                stack["backgroundMusic"]!.play();
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
        func playSoundEffect() {
            
        }
    
    static func playButtonSoundEffect(audioFileName: String){
        
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
    
    static func dispatchAudio() {
        //let audioStack = [backgroundMusicTrack, buttonSoundEffectTrack]
        
        
    }
}
