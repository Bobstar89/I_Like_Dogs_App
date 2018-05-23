//
//  P3ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 12/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit

class FifthPageController: StorybookController {
    let storybookPageNumber = 5
    
    @IBOutlet weak var hole: UIImageView!
    @IBOutlet weak var flower: UIImageView!
    @IBOutlet weak var flower2: UIImageView!
    @IBOutlet weak var flower3: UIImageView!
    
    var holeAnimation = [UIImage]()
    var flowerAnimation = [UIImage]()
    var flower2Animation = [UIImage]()
    var flower3Animation = [UIImage]()
    
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var Like: UILabel!
    @IBOutlet weak var CurlyHaired: UILabel!
    @IBOutlet weak var Dogs: UILabel!
    
    var pageText = [UILabel]()
    
    override func viewDidLoad() {
        super.updateMusicBtnImage();
        super.updateNarrationBtnImage();
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)
        
        I.text = ""
        Like.text = ""
        CurlyHaired.text = ""
        Dogs.text = ""
        pageText.append(I)
        pageText.append(Like);
        pageText.append(CurlyHaired);
        pageText.append(Dogs);
        
        I.addGestureRecognizer(setupAnimationTapRecognition())
        I.isUserInteractionEnabled = true
        
        Like.addGestureRecognizer(setupAnimationTapRecognition())
        Like.isUserInteractionEnabled = true
        
        CurlyHaired.addGestureRecognizer(setupAnimationTapRecognition())
        CurlyHaired.isUserInteractionEnabled = true
        
        Dogs.addGestureRecognizer(setupAnimationTapRecognition())
        Dogs.isUserInteractionEnabled = true
        
        hole.addGestureRecognizer(setupAnimationTapRecognition())
            hole.isUserInteractionEnabled = true
        
        flower.addGestureRecognizer(setupAnimationTapRecognition())
        flower.isUserInteractionEnabled = true
        
        flower2.addGestureRecognizer(setupAnimationTapRecognition())
        flower2.isUserInteractionEnabled = true
        
        flower3.addGestureRecognizer(setupAnimationTapRecognition())
        flower3.isUserInteractionEnabled = true
        
        holeAnimation = retrieveAnimationImages(name: "Hole", numOfImages: 29)
        
        flowerAnimation = retrieveAnimationImages(name: "Flower", numOfImages: 29)
        
        flower2Animation = retrieveAnimationImages(name: "FlowerB", numOfImages: 29)
        
        flower3Animation = retrieveAnimationImages(name: "FlowerC", numOfImages: 29)
        
        initialiseAnimation(sceneImage: hole, animation: holeAnimation)
        
        I.tag = 1
        Like.tag = 2
        CurlyHaired.tag = 3
        Dogs.tag = 4
        hole.tag = 5
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
            hole.startAnimating()
            break
        default:
            return
        }
    }

}
