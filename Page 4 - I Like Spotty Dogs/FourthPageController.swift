//
//  P3ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 12/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit

class FourthPageController: StorybookController {
    let storybookPageNumber = 4
    
    @IBOutlet weak var flower: UIImageView!
    @IBOutlet weak var flower2: UIImageView!
    @IBOutlet weak var flower3: UIImageView!
    @IBOutlet weak var bush: UIImageView!
    @IBOutlet weak var sheet: UIImageView!
    
    var flowerAnimation = [UIImage]();
    var flowerAnimation2 = [UIImage]();
    var flowerAnimation3 = [UIImage]();
    var bushAnimation = [UIImage]();
    var sheetAnimation = [UIImage]();
    
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var Like: UILabel!
    @IBOutlet weak var Spotty: UILabel!
    @IBOutlet weak var Dogs: UILabel!
    
    var pageText = [UILabel]()
    
    override func viewDidLoad() {
        super.updateMusicBtnImage();
        super.updateNarrationBtnImage();
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)

        I.text = ""
        Like.text = ""
        Spotty.text = ""
        Dogs.text = ""
        pageText.append(I)
        pageText.append(Like);
        pageText.append(Spotty);
        pageText.append(Dogs);
        
        flower.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower.isUserInteractionEnabled = true
        
        flower2.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower2.isUserInteractionEnabled = true
        
        flower3.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower3.isUserInteractionEnabled = true
        bush.addGestureRecognizer(self.setupAnimationTapRecognition())
        bush.isUserInteractionEnabled = true
        
        sheet.addGestureRecognizer(self.setupAnimationTapRecognition())
        sheet.isUserInteractionEnabled = true
        
        I.addGestureRecognizer(setupAnimationTapRecognition())
        I.isUserInteractionEnabled = true
        
        Like.addGestureRecognizer(setupAnimationTapRecognition())
        Like.isUserInteractionEnabled = true
        
        Spotty.addGestureRecognizer(setupAnimationTapRecognition())
        Spotty.isUserInteractionEnabled = true
        
        Dogs.addGestureRecognizer(setupAnimationTapRecognition())
        Dogs.isUserInteractionEnabled = true
        
        I.tag = 1
        Like.tag = 2
        Spotty.tag = 3
        Dogs.tag = 4
        
        flower.tag = 5
        flower2.tag = 6
        flower3.tag = 7
        bush.tag = 8
        sheet.tag = 9
        
        //numOfImages shown in the "bone animation" folder of "Assets.xcassets"
        flowerAnimation = super.retrieveAnimationImages(name: "Flower", numOfImages: 29);
        flowerAnimation2 = super.retrieveAnimationImages(name: "FlowerB", numOfImages: 29);
        flowerAnimation3 = super.retrieveAnimationImages(name: "FlowerC", numOfImages: 29);
        
        //numOfImages shown in the "ball animation" folder of "Assets.xcassets"
        bushAnimation = super.retrieveAnimationImages(name: "bush", numOfImages: 24);
        
        //numOfImages shown in the "apple animation" folder of "Assets.xcassets"
        sheetAnimation = super.retrieveAnimationImages(name: "sheet", numOfImages: 53);
        
        initialiseAnimation(sceneImage: flower, animation: flowerAnimation)
        initialiseAnimation(sceneImage: flower2, animation: flowerAnimation2)
        initialiseAnimation(sceneImage: flower3, animation: flowerAnimation3)
        initialiseAnimation(sceneImage: bush, animation: bushAnimation)
        initialiseAnimation(sceneImage: sheet, animation: sheetAnimation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
        Narrator.setScriptWords(pageNumber: 4)
        Narrator.setScriptAudio(pageNumber: 4)
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
            flower.startAnimating()
            break
        case 6:
            flower2.startAnimating()
            break
        case 7:
            flower3.startAnimating()
            break
        case 8:
            bush.startAnimating()
            break
        case 9:
            sheet.startAnimating()
            break
        default:
            return
        }
    }
}
