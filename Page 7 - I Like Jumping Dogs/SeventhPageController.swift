//
//  P3ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 12/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit

class SeventhPageController: StorybookController {
    var storybookPageNumber = 7
    
    @IBOutlet weak var flower: UIImageView!
    @IBOutlet weak var flower2: UIImageView!
    @IBOutlet weak var flower3: UIImageView!
    @IBOutlet weak var bush: UIImageView!
    @IBOutlet weak var bush2: UIImageView!
    @IBOutlet weak var bush3: UIImageView!
    
    var flowerAnimation = [UIImage]();
    var flowerAnimation2 = [UIImage]();
    var flowerAnimation3 = [UIImage]();
    var bushAnimation = [UIImage]();
    var bushAnimation2 = [UIImage]();
    var bushAnimation3 = [UIImage]();
    
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var Like: UILabel!
    @IBOutlet weak var Jumping: UILabel!
    @IBOutlet weak var Dogs: UILabel!
    
    var pageText = [UILabel]()
    var spriteObjectTapRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.updateMusicBtnImage();
        super.updateNarrationBtnImage();
        
        I.text = ""
        Like.text = ""
        Jumping.text = ""
        Dogs.text = ""
        pageText.append(I)
        pageText.append(Like);
        pageText.append(Jumping);
        pageText.append(Dogs);
        
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)
         flower.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower.isUserInteractionEnabled = true
        
        flower2.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower2.isUserInteractionEnabled = true
        
        flower3.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower3.isUserInteractionEnabled = true
        bush.addGestureRecognizer(self.setupAnimationTapRecognition())
        bush.isUserInteractionEnabled = true
        bush2.addGestureRecognizer(self.setupAnimationTapRecognition())
        bush.isUserInteractionEnabled = true
        bush3.addGestureRecognizer(self.setupAnimationTapRecognition())
        bush.isUserInteractionEnabled = true
        
        flower.tag = 1
        flower2.tag = 2
        flower3.tag = 3
        bush.tag = 4
        bush2.tag = 5
        bush3.tag = 6
        
        //numOfImages shown in the "bone animation" folder of "Assets.xcassets"
        flowerAnimation = super.retrieveAnimationImages(name: "Flower", numOfImages: 29);
        flowerAnimation2 = super.retrieveAnimationImages(name: "FlowerC", numOfImages: 29);
        flowerAnimation3 = super.retrieveAnimationImages(name: "FlowerB", numOfImages: 29);

        bushAnimation = super.retrieveAnimationImages(name: "BushB", numOfImages: 24)
        
        bushAnimation2 = super.retrieveAnimationImages(name: "bush", numOfImages: 24)
        
        bushAnimation3 = super.retrieveAnimationImages(name: "bush", numOfImages: 24)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
        Narrator.setScriptWords(pageNumber: 7)
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
        
        if(sender.view!.tag == 1) {
            initialiseAnimation(sceneImage: flower, animation: flowerAnimation)
        }
        else
        if(sender.view!.tag == 2) {
            initialiseAnimation(sceneImage: flower2, animation: flowerAnimation2)
        }
        else
        if(sender.view!.tag == 3) {
            initialiseAnimation(sceneImage: flower3, animation: flowerAnimation3)
        }
        else
        if(sender.view!.tag == 4) {
            initialiseAnimation(sceneImage: bush, animation: bushAnimation)
        }
        else
        if(sender.view!.tag == 5) {
            initialiseAnimation(sceneImage: bush2, animation: bushAnimation2)
        }
        else
        if(sender.view!.tag == 6) {
            initialiseAnimation(sceneImage: bush3, animation: bushAnimation3)
        }
    }
}
