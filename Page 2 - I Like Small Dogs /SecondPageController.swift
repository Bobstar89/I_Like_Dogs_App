//
//  P2ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 12/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit

class SecondPageController: StorybookController{
    let storybookPageNumber = 2
    
    @IBOutlet weak var apple: UIImageView!
    @IBOutlet weak var bone: UIImageView!
    @IBOutlet weak var flower: UIImageView!
    @IBOutlet weak var flower2: UIImageView!
    @IBOutlet weak var flower3: UIImageView!
    
    var appleAnimation = [UIImage]();
    var boneAnimation = [UIImage]();
    var flowerAnimation = [UIImage]();
    var flowerAnimation2 = [UIImage]();
    var flowerAnimation3 = [UIImage]();
    
    var pageText = [UILabel]()
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var Like: UILabel!
    @IBOutlet weak var Small: UILabel!
    @IBOutlet weak var Dogs: UILabel!
    
    override func viewDidLoad() {
        super.updateMusicBtnImage();
        super.updateNarrationBtnImage();
        
        I.text = ""
        Like.text = ""
        Small.text = ""
        Dogs.text = ""
        pageText.append(I)
        pageText.append(Like)
        pageText.append(Small)
        pageText.append(Dogs)
        
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)
        apple.addGestureRecognizer(self.setupAnimationTapRecognition())
        apple.isUserInteractionEnabled = true
        bone.addGestureRecognizer(self.setupAnimationTapRecognition())
        bone.isUserInteractionEnabled = true
        flower.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower.isUserInteractionEnabled = true
        
        flower2.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower2.isUserInteractionEnabled = true
        
        flower3.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower3.isUserInteractionEnabled = true
        bone.addGestureRecognizer(self.setupAnimationTapRecognition())
        bone.isUserInteractionEnabled = true
        
        apple.tag = 1
        bone.tag = 2
        flower.tag = 3
        flower2.tag = 4
        flower3.tag = 5
        
        //numOfImages shown in the "ball animation" folder of "Assets.xcassets"
        appleAnimation = super.retrieveAnimationImages(name: "apple", numOfImages: 24);
        
        //numOfImages shown in the "apple animation" folder of "Assets.xcassets"
        boneAnimation = super.retrieveAnimationImages(name: "Bone", numOfImages: 46);
        
        //numOfImages shown in the "bone animation" folder of "Assets.xcassets"
        flowerAnimation = super.retrieveAnimationImages(name: "Flower", numOfImages: 29);
        flowerAnimation2 = super.retrieveAnimationImages(name: "FlowerC", numOfImages: 29);
        flowerAnimation3 = super.retrieveAnimationImages(name: "FlowerB", numOfImages: 29);
        
        Narrator.setScriptAudio(pageNumber: 2);
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
        Narrator.setScriptWords(pageNumber: storybookPageNumber)
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
            apple.frame = CGRect(x: 282, y: 20, width: 77, height: 1000)
            initialiseAnimation(sceneImage: apple, animation: appleAnimation)
        }
        else
        if(sender.view!.tag == 2) {
            initialiseAnimation(sceneImage: bone, animation: boneAnimation)
        }
        else
        if(sender.view!.tag == 3) {
            initialiseAnimation(sceneImage: flower, animation: flowerAnimation)
        }
        else
        if(sender.view!.tag == 4) {
            initialiseAnimation(sceneImage: flower2, animation: flowerAnimation2)
        }
        else
        if(sender.view!.tag == 5) {
            initialiseAnimation(sceneImage: flower3, animation: flowerAnimation3)
        }
    }
}
