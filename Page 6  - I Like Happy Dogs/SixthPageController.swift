//
//  P6ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 12/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit

class SixthPageController: StorybookController {
    let storybookPageNumber = 6
    
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var Like: UILabel!
    @IBOutlet weak var Happy: UILabel!
    @IBOutlet weak var Dogs: UILabel!
    
    var pageText = [UILabel]()
    
    override func viewDidLoad() {
        super.updateMusicBtnImage();
        super.updateNarrationBtnImage();
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)

        I.text = ""
        Like.text = ""
        Happy.text = ""
        Dogs.text = ""
        pageText.append(I)
        pageText.append(Like);
        pageText.append(Happy);
        pageText.append(Dogs);
        
        I.addGestureRecognizer(setupAnimationTapRecognition())
        I.isUserInteractionEnabled = true
        
        Like.addGestureRecognizer(setupAnimationTapRecognition())
        Like.isUserInteractionEnabled = true
        
        Happy.addGestureRecognizer(setupAnimationTapRecognition())
        Happy.isUserInteractionEnabled = true
        
        Dogs.addGestureRecognizer(setupAnimationTapRecognition())
        Dogs.isUserInteractionEnabled = true
        
        I.tag = 1
        Like.tag = 2
        Happy.tag = 3
        Dogs.tag = 4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
        Narrator.setScriptWords(pageNumber: storybookPageNumber)
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)
        Narrator.getScriptAudio()
        readScript()
    }
    
    func readScript() {
        let wordTimes = Narrator.getWordTiming(pageNumber: storybookPageNumber)
        var timeUntilWordIsSpoken = 0.0
        var currentScriptWord: String
        
        
        for i in 0..<pageText.count {
            currentScriptWord = Narrator.getScriptWord(atIndex: i)
            highlightWord(text: pageText[i], word: currentScriptWord, duration: wordTimes[i], atTime: timeUntilWordIsSpoken)
            timeUntilWordIsSpoken += wordTimes[i]
        }
    }
    
    func highlightWord(text: UILabel, word: String, duration: Double, atTime: Double) {
        let redHighlight = updateText(text: word)
        redHighlight.frame = text.bounds
        
        let animation = CABasicAnimation(keyPath: "foregroundColor")
        
        animation.fromValue = UIColor.red.cgColor;
        animation.toValue = UIColor.white.cgColor;
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + atTime
        
        text.layer.addSublayer(redHighlight)
        redHighlight.add(animation, forKey: "foregroundColor")
    }
    
    override func playAnimation(_ sender: UITapGestureRecognizer) {
        let wordTimes = Narrator.getWordTiming(pageNumber: storybookPageNumber)
        
        switch sender.view!.tag {
        case 1:
            highlightWord(text: pageText[0], word: Narrator.getScriptWord(atIndex: 0), duration: wordTimes[0], atTime: 0)
            Narrator.readWord(word: Narrator.getScriptWord(atIndex: 0))
            break
        case 2:
            highlightWord(text: pageText[1], word: Narrator.getScriptWord(atIndex: 1), duration: wordTimes[1], atTime: 0)
            Narrator.readWord(word: Narrator.getScriptWord(atIndex: 1))
            break
        case 3:
            highlightWord(text: pageText[2], word: Narrator.getScriptWord(atIndex: 2), duration: wordTimes[2], atTime: 0)
            Narrator.readWord(word: Narrator.getScriptWord(atIndex: 2))
            break
        case 4:
            highlightWord(text: pageText[3], word: Narrator.getScriptWord(atIndex: 3), duration: wordTimes[3], atTime: 0)
            Narrator.readWord(word: Narrator.getScriptWord(atIndex: 3))
            break
        default:
            return
        }
    }

}
