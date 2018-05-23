//
//  P1ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 12/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit

/*
                             ==========================
                               FIRST PAGE CONTROLLER
                             ==========================

                        The first page features the following images
                        that are animated by initializeAnimation() :
 
                            * Apple
                            * Ball
                            * Bone
 */
class FirstPageController: StorybookController {
    let storybookPageNumber = 1
    
    var ballAnimation = [UIImage]();
    var appleAnimation = [UIImage]();
    var boneAnimation = [UIImage]();
    var millAnimation = [UIImage]();
    
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var Like: UILabel!
    @IBOutlet weak var Dogs: UILabel!
    
    var pageText = [UILabel]()
    var spriteObjectTapRecognizer = UITapGestureRecognizer()
    
    @IBOutlet weak var apple: UIImageView!
    @IBOutlet weak var apple2: UIImageView!
    @IBOutlet weak var apple3: UIImageView!
    @IBOutlet weak var ball: UIImageView!
    @IBOutlet weak var bone: UIImageView!
    @IBOutlet weak var mill: UIImageView!
    @IBOutlet weak var dog: UIImageView!
    
    /*  Name: narratorTracks
 
        Description: Store the narration words to be sounded by the Music Player
    */
    
    /*  Name: viewDidLoad()
     
        Description: Once the page is loaded, update the default music and narration
                     graphic featured in "Main.storyboard" to adapt to the current
                     music settings.
     
                     The last purpose of viewDidLoad is to attach touch gesture
                     recognizers to the animatable objects and retrieve their
                     associated animation images.
 
    */
   
    override func viewDidLoad() {
        
            I.text = ""
            Like.text = ""
            Dogs.text = ""
            pageText.append(I)
            pageText.append(Like);
            pageText.append(Dogs);
        
        // Add user touch functionality for: apples, tennis ball and dog bone
            apple.addGestureRecognizer(self.setupAnimationTapRecognition())
            apple.isUserInteractionEnabled = true
        
            apple2.addGestureRecognizer(self.setupAnimationTapRecognition())
            apple2.isUserInteractionEnabled = true
        
            apple3.addGestureRecognizer(self.setupAnimationTapRecognition())
            apple3.isUserInteractionEnabled = true
        
            bone.addGestureRecognizer(self.setupAnimationTapRecognition())
            bone.isUserInteractionEnabled = true
        
            ball.addGestureRecognizer(self.setupAnimationTapRecognition())
            ball.isUserInteractionEnabled = true;
        
            mill.addGestureRecognizer(self.setupAnimationTapRecognition())
            mill.isUserInteractionEnabled = true;
        
        dog.addGestureRecognizer(self.setupAnimationTapRecognition())
        dog.isUserInteractionEnabled = true;
        

        I.addGestureRecognizer(setupAnimationTapRecognition())
        I.isUserInteractionEnabled = true
        
        Like.addGestureRecognizer(setupAnimationTapRecognition())
        Like.isUserInteractionEnabled = true
        
        Dogs.addGestureRecognizer(setupAnimationTapRecognition())
        Dogs.isUserInteractionEnabled = true
        
        // tags are used to identify which object was touched in the screen
            I.tag = 1
            Like.tag = 2
            Dogs.tag = 3
            apple.tag = 4
            apple2.tag = 5
            apple3.tag = 6
            ball.tag = 7
            bone.tag = 8
            mill.tag = 9
            dog.tag = 10
        
        // numOfImages shown in the "ball animation" folder of "Assets.xcassets"
            ballAnimation = super.retrieveAnimationImages(name: "Ball", numOfImages: 29);
        
        // numOfImages shown in the "apple animation" folder of "Assets.xcassets"
            appleAnimation = super.retrieveAnimationImages(name: "Apple", numOfImages: 59);
            appleAnimation.append(appleAnimation.last!)

        
        // numOfImages shown in the "bone animation" folder of "Assets.xcassets"
            boneAnimation = super.retrieveAnimationImages(name: "Bone", numOfImages: 45);
        
            millAnimation = super.retrieveAnimationImages(name: "Mill", numOfImages: 30);
        
        
        
            initialiseAnimation(sceneImage: apple, animation: appleAnimation)
            initialiseAnimation(sceneImage: apple2, animation: appleAnimation)
            initialiseAnimation(sceneImage: apple3, animation: appleAnimation)
            initialiseAnimation(sceneImage: ball, animation: ballAnimation)
            initialiseAnimation(sceneImage: bone, animation: boneAnimation)
            initialiseAnimation(sceneImage: mill, animation: millAnimation)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
        Narrator.setScriptWords(pageNumber: 1)
        Narrator.setScriptAudio(pageNumber: 1)
        
        if (MusicPlayer.getNarrationState() == true) {
            Narrator.getScriptAudio()
        }
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


    /*  Name: initialiseAnimation(sceneImage, animation)
     
        Description: given a "sceneImage", get the appropriate animation images
                     with the apprpriate duration
     
     */
    
    

    /*  Name: playAnimation
     
        Description: given a tap gesture's view tag, show the associated animation for the
                     image that was tapped
    */
    
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
                let currentFrame = apple.frame
                let firstImage = apple.image
                apple.frame = CGRect(x: 208, y: 284, width: 80, height: 3200)
                apple.startAnimating()

                UIView.animate(withDuration: 0, delay: (getFramesPerSecond(numOfFrames: appleAnimation.count)), animations: {
                    self.apple.image = firstImage
                    self.apple.frame = currentFrame
                })
                break
            case 5:
                let currentFrame = apple2.frame
                let firstImage = apple2.image
                apple2.frame = CGRect(x: 31, y: 263, width: 80, height: 3200)
                
                apple2.startAnimating()
                
                UIView.animate(withDuration: 0, delay: getFramesPerSecond(numOfFrames: appleAnimation.count), animations: {
                    self.apple2.image = firstImage
                    self.apple2.frame = currentFrame
                })
                break
            case 6:
                let currentFrame = apple3.frame
                let firstImage = apple3.image
                apple3.frame = CGRect(x: 102, y: 92, width: 80, height: 3200)
                
                apple3.startAnimating()
                
                UIView.animate(withDuration: 0, delay: getFramesPerSecond(numOfFrames: appleAnimation.count - 1), animations: {
                    self.apple3.image = firstImage
                    self.apple3.frame = currentFrame
                })
            break
            case 7:
                ball.startAnimating()
                break
            case 8:
                bone.startAnimating()
                break
            case 9:
                mill.animationRepeatCount = 2
                mill.startAnimating()
                break
            case 10:
                MusicPlayer.playSoundEffect(audioFileName: "small-dog-bark")
                break
            default:
                return
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
