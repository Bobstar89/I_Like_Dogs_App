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
    @IBOutlet weak var smallDog: UIImageView!
    
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
        
        smallDog.addGestureRecognizer(self.setupAnimationTapRecognition())
        smallDog.isUserInteractionEnabled = true
        
        I.addGestureRecognizer(setupAnimationTapRecognition())
        I.isUserInteractionEnabled = true
        
        Like.addGestureRecognizer(setupAnimationTapRecognition())
        Like.isUserInteractionEnabled = true
        
        Small.addGestureRecognizer(setupAnimationTapRecognition())
        Small.isUserInteractionEnabled = true
        
        Dogs.addGestureRecognizer(setupAnimationTapRecognition())
        Dogs.isUserInteractionEnabled = true
        
        I.tag = 1
        Like.tag = 2
        Small.tag = 3
        Dogs.tag = 4
        apple.tag = 5
        bone.tag = 6
        flower.tag = 7
        flower2.tag = 8
        flower3.tag = 9
        smallDog.tag = 10
        
        //numOfImages shown in the "ball animation" folder of "Assets.xcassets"
        appleAnimation = super.retrieveAnimationImages(name: "Apple", numOfImages: 18);
        
        //numOfImages shown in the "apple animation" folder of "Assets.xcassets"
        boneAnimation = super.retrieveAnimationImages(name: "Bone", numOfImages: 45);
        
        //numOfImages shown in the "bone animation" folder of "Assets.xcassets"
        flowerAnimation = super.retrieveAnimationImages(name: "Flower", numOfImages: 29);
        flowerAnimation2 = super.retrieveAnimationImages(name: "FlowerC", numOfImages: 29);
        flowerAnimation3 = super.retrieveAnimationImages(name: "FlowerB", numOfImages: 29);
        
        initialiseAnimation(sceneImage: apple, animation: appleAnimation)
        initialiseAnimation(sceneImage: bone, animation: boneAnimation)
        initialiseAnimation(sceneImage: flower, animation: flowerAnimation)
        initialiseAnimation(sceneImage: flower2, animation: flowerAnimation2)
        initialiseAnimation(sceneImage: flower3, animation: flowerAnimation3)
        
        Narrator.setScriptAudio(pageNumber: 2);
        
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
            apple.frame = CGRect(x: 282, y: 20, width: 77, height: 1000)
            apple.startAnimating();
            apple.image = nil
            break
        case 6:
            bone.startAnimating()
            break
        case 7:
            flower.startAnimating()
            break
        case 8:
            flower2.startAnimating()
            break
        case 9:
            flower3.startAnimating()
            break
        case 10:
            MusicPlayer.playSoundEffect(audioFileName: "small-dog-bark")
        default:
            return
        }
    }
}
