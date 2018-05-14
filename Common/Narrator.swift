//
//  Narrator.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 2/5/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit;
import AVFoundation;

class Narrator: NSObject {
/*   Name: segmentedScript
 
     Description: stores each word in the narration script as an audio file
                  which features the words being spoken by the client
     
     Used by: setWordAudio( pageNumber )
*/
    private static var segmentedScript = [String : AVAudioPlayer]();

/*   Name: fullScript
     
     Description: Stores the full audio based narration into an AVAudioPlayer
 
 */
    
    private static var fullScriptAudio = AVAudioPlayer()
    private static var scriptLocation: URL!
    private static var scriptWords = [String]();
    private static var session: AVAudioSession!;
    
    static func setScriptWords(pageNumber: Int){
        switch pageNumber {
        case 1 :
            scriptWords = ["I", "Like", "Dogs"];
            break;
        case 2 :
            scriptWords = ["I", "Like", "Small", "Dogs"];
            break;
        case 3 :
            scriptWords = ["I", "Like", "Big", "Dogs"];
            break;
        case 4 :
            scriptWords = ["I", "Like", "Spotty", "Dogs"];
            break;
        case 5 :
            scriptWords = ["I", "Like", "Curly-haired", "Dogs"];
            break;
        case 6 :
            scriptWords = ["I", "Like", "Happy", "Dogs"];
            break;
        case 7 :
            scriptWords = ["I", "Like", "Jumping", "Dogs"];
            break;
        case 8 :
            scriptWords = ["But", "Most", "Of", "All...", "I", "Like", "My", "Dog"];
            break;
        default:
            scriptWords = ["I would like a type of dog to like"]
        }
    }
    
    static func getScriptWord(atIndex: Int) -> String{
        return scriptWords[atIndex]
    }
    
    static func setScriptAudio(pageNumber: Int) {
        session = AVAudioSession.sharedInstance()
        try! session.setActive(true)
        
        print(scriptWords)
        for i in 0..<scriptWords.count {
            // Find each script word, used for clicking individual words
                scriptLocation = findScriptLocation(scriptAudioIdentifier: "\(getScriptWord(atIndex: i))", audioFormat: "mp3");
            
                do {
                        let wordAudio = try AVAudioPlayer(contentsOf: scriptLocation)
                    
                        segmentedScript["\(scriptWords[i])"] = wordAudio;
                        segmentedScript["\(scriptWords[i])"]?.volume = 0.5
                }
                catch { print(error) }
        }
        
        // Find full script's location
        scriptLocation = findScriptLocation(scriptAudioIdentifier: "page\(pageNumber)-full-narration", audioFormat: "mp3");
        
        do {
            fullScriptAudio = try AVAudioPlayer(contentsOf: scriptLocation)
            fullScriptAudio.volume = 0.5
        }
        catch { print(error) }
    }
    
    static func findScriptLocation(scriptAudioIdentifier: String, audioFormat: String) -> URL{
            
            // path is unchangeable and stores the absolute audio location
            let path = Bundle.main.path(forResource: scriptAudioIdentifier, ofType: audioFormat)!
        
            // return the location as a URL() object
            return URL(fileURLWithPath: path);
    }
    
    static func getWordTiming(pageNumber: Int) -> [Double] {
        var wordTiming = [Double]()
        
        switch pageNumber {
        case 1:
            wordTiming.append(0.553)
            wordTiming.append(0.711)
            wordTiming.append(0.799)
            return wordTiming
        case 2:
            wordTiming.append(0.513)
            wordTiming.append(0.413)
            wordTiming.append(1.083)
            wordTiming.append(0.927)
        case 3:
            wordTiming.append(0.598)
            wordTiming.append(0.537)
            wordTiming.append(0.901)
            wordTiming.append(0.804)
        case 4:
            wordTiming.append(0.722)
            wordTiming.append(0.454)
            wordTiming.append(1.395)
            wordTiming.append(0.915)
        case 5:
            wordTiming.append(0.729)
            wordTiming.append(0.344)
            wordTiming.append(1.795)
            wordTiming.append(0.908)
        case 6:
            wordTiming.append(0.707)
            wordTiming.append(0.465)
            wordTiming.append(1.395)
            wordTiming.append(0.915)
        case 7:
            wordTiming.append(0.440)
            wordTiming.append(0.585)
            wordTiming.append(1.059)
            wordTiming.append(0.724)
        case 8:
            wordTiming.append(0.378)
            wordTiming.append(0.447)
            wordTiming.append(0.241)
            wordTiming.append(0.722)
            wordTiming.append(0.488)
            wordTiming.append(0.502)
            wordTiming.append(0.984)
            wordTiming.append(0.757)
        default:
            print("page number not set")
        }
        
        return wordTiming
    }
    
    static func getScriptAudio() {
        fullScriptAudio.play()
    }
    
    
    
    
    static func isReadingScript() -> Bool {
        if(fullScriptAudio.isPlaying) {
            return true;
        }
        else {
            return false;
        }
    }
    
    static func stopReadingScript() {
        if(isReadingScript()) {
            fullScriptAudio.stop()
        }
    }
}
