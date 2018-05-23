//
//  P3ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 12/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit

class ThirdPageController: StorybookController{
    let storybookPageNumber = 3
    
    @IBOutlet weak var flower: UIImageView!
    @IBOutlet weak var flower2: UIImageView!
    @IBOutlet weak var flower3: UIImageView!
    @IBOutlet weak var ball: UIImageView!
    @IBOutlet weak var bush: UIImageView!
    @IBOutlet weak var bush2: UIImageView!
    
    private var flowerAnimation: [UIImage]!
    private var flowerAnimation2: [UIImage]!
    private var flowerAnimation3: [UIImage]!
    private var bushAnimation: [UIImage]!
    private var bush2Animation: [UIImage]!
    private var ballAnimation: [UIImage]!
    
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var Like: UILabel!
    @IBOutlet weak var Big: UILabel!
    @IBOutlet weak var Dogs: UILabel!
    
    var pageText = [UILabel]()
    
    override func viewDidLoad() {
        // Display narration and music button with appropriate graphics
        // to suit associated "MusicPlayer" states "isNarrationOn" and "isMusicOn"
        super.updateMusicBtnImage();
        super.updateNarrationBtnImage();
        
        I.text = ""
        Like.text = ""
        Big.text = ""
        Dogs.text = ""
        pageText.append(I)
        pageText.append(Like)
        pageText.append(Big)
        pageText.append(Dogs)
        
        // Add user touch functionality for: apples, tennis ball and dog bone
        
        flower.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower.isUserInteractionEnabled = true
        
        flower2.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower2.isUserInteractionEnabled = true
        
        flower3.addGestureRecognizer(self.setupAnimationTapRecognition())
        flower3.isUserInteractionEnabled = true
        
        bush.addGestureRecognizer(self.setupAnimationTapRecognition())
        bush.isUserInteractionEnabled = true
        
        bush2.addGestureRecognizer(self.setupAnimationTapRecognition())
        bush2.isUserInteractionEnabled = true
        
        ball.addGestureRecognizer(self.setupAnimationTapRecognition())
        ball.isUserInteractionEnabled = true;
        
        I.addGestureRecognizer(setupAnimationTapRecognition())
        I.isUserInteractionEnabled = true
        
        Like.addGestureRecognizer(setupAnimationTapRecognition())
        Like.isUserInteractionEnabled = true
        
        Big.addGestureRecognizer(setupAnimationTapRecognition())
        Big.isUserInteractionEnabled = true
        
        Dogs.addGestureRecognizer(setupAnimationTapRecognition())
        Dogs.isUserInteractionEnabled = true
        
        // tags are used to identify which object was touched in the screen
        
        I.tag = 1
        Like.tag = 2
        Big.tag = 3
        Dogs.tag = 4
        flower.tag = 5
        flower2.tag = 6
        flower3.tag = 7
        ball.tag = 8
        bush2.tag = 9
        bush.tag = 10
        
        
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)
        // numOfImages shown in the "apple animation" folder of "Assets.xcassets"
        flowerAnimation = super.retrieveAnimationImages(name: "Flower", numOfImages: 29);
        
        // numOfImages shown in the "bone animation" folder of "Assets.xcassets"
        flowerAnimation2 = super.retrieveAnimationImages(name: "FlowerB", numOfImages: 29);
        
        flowerAnimation3 = super.retrieveAnimationImages(name: "FlowerC", numOfImages: 29);
        
        // numOfImages shown in the "ball animation" folder of "Assets.xcassets"
        ballAnimation = super.retrieveAnimationImages(name: "Ball", numOfImages: 29);
        
        // numOfImages shown in the "bone animation" folder of "Assets.xcassets"
        bushAnimation = super.retrieveAnimationImages(name: "bush", numOfImages: 24);
        
        bush2Animation = super.retrieveAnimationImages(name: "BushB", numOfImages: 24);

        initialiseAnimation(sceneImage: flower, animation: flowerAnimation)
        initialiseAnimation(sceneImage: flower2, animation: flowerAnimation2)
        initialiseAnimation(sceneImage: flower3, animation: flowerAnimation3)
        initialiseAnimation(sceneImage: ball, animation: ballAnimation)
        initialiseAnimation(sceneImage: bush, animation: bushAnimation)
        initialiseAnimation(sceneImage: bush2, animation: bush2Animation)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
        Narrator.setScriptWords(pageNumber: storybookPageNumber)
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)
        Narrator.getScriptAudio()
        readScript()
    }

    /*  Name: initialiseAnimation(sceneImage, animation)
     
     Description: given a "sceneImage", get the appropriate animation images
     with the apprpriate duration
     
     */
    
    /*  Name: playAnimation
     
     Description: given a tap gesture's view tag, show the associated animation for the
     image that was tapped
     */
    
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
            ball.startAnimating()
            break
        case 9:
            bush2.startAnimating()
            break
        case 10:
            bush.startAnimating()
            break
        default:
            return
        }
    }
}
