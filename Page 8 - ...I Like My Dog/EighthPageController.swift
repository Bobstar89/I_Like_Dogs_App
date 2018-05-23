//
//  P8ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 12/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit

class EighthPageController: StorybookController{
    let storybookPageNumber = 8
    
    @IBOutlet weak var But: UILabel!
    @IBOutlet weak var Most: UILabel!
    @IBOutlet weak var Of: UILabel!
    @IBOutlet weak var All: UILabel!
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var Like: UILabel!
    @IBOutlet weak var My: UILabel!
    @IBOutlet weak var Dog: UILabel!
    
    var pageText = [UILabel]()
    
    override func viewDidLoad() {
        super.updateMusicBtnImage();
        super.updateNarrationBtnImage();
        
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)
        
        But.text = ""
        Most.text = ""
        Of.text = ""
        All.text = ""
        I.text = ""
        Like.text = ""
        My.text = ""
        Dog.text = ""

        pageText.append(But)
        pageText.append(Most)
        pageText.append(Of)
        pageText.append(All)
        pageText.append(I)
        pageText.append(Like)
        pageText.append(My)
        pageText.append(Dog)
        
        But.addGestureRecognizer(setupAnimationTapRecognition())
        But.isUserInteractionEnabled = true
        
        Most.addGestureRecognizer(setupAnimationTapRecognition())
        Most.isUserInteractionEnabled = true
        
        Of.addGestureRecognizer(setupAnimationTapRecognition())
        Of.isUserInteractionEnabled = true
        
        All.addGestureRecognizer(setupAnimationTapRecognition())
        All.isUserInteractionEnabled = true
        
        I.addGestureRecognizer(setupAnimationTapRecognition())
        I.isUserInteractionEnabled = true
        
        Like.addGestureRecognizer(setupAnimationTapRecognition())
        Like.isUserInteractionEnabled = true
        
        My.addGestureRecognizer(setupAnimationTapRecognition())
        My.isUserInteractionEnabled = true
        
        Dog.addGestureRecognizer(setupAnimationTapRecognition())
        Dog.isUserInteractionEnabled = true
        
        But.tag = 1
        Most.tag = 2
        Of.tag = 3
        All.tag = 4
        I.tag = 5
        Like.tag = 6
        My.tag = 7
        Dog.tag = 8
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
        case 5:
            highlightWord(text: pageText[4], word: Narrator.getScriptWord(atIndex: 4), duration: wordTimes[4], atTime: 0)
            Narrator.readWord(word: Narrator.getScriptWord(atIndex: 4))
            break
        case 6:
            highlightWord(text: pageText[5], word: Narrator.getScriptWord(atIndex: 5), duration: wordTimes[5], atTime: 0)
            Narrator.readWord(word: Narrator.getScriptWord(atIndex: 5))
            break
        case 7:
            highlightWord(text: pageText[6], word: Narrator.getScriptWord(atIndex: 6), duration: wordTimes[6], atTime: 0)
            Narrator.readWord(word: Narrator.getScriptWord(atIndex: 6))
            break
        case 8:
            highlightWord(text: pageText[7], word: Narrator.getScriptWord(atIndex: 7), duration: wordTimes[7], atTime: 0)
            Narrator.readWord(word: Narrator.getScriptWord(atIndex: 7))
            break
        default:
            return
        }
    }

}
