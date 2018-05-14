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
        // Display narration and music button with appropriate graphics
        // to suit associated "MusicPlayer" states "isNarrationOn" and "isMusicOn"
            super.updateMusicBtnImage();
            super.updateNarrationBtnImage();
        
            I.text = ""
            Like.text = ""
            Dogs.text = ""
            pageText.append(I)
            pageText.append(Like);
            pageText.append(Dogs);
        
            Narrator.setScriptAudio(pageNumber: storybookPageNumber)
        
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
        
        // tags are used to identify which object was touched in the screen
            apple.tag = 1
            apple2.tag = 2
            apple3.tag = 3
            ball.tag = 4
            bone.tag = 5
        
        // numOfImages shown in the "ball animation" folder of "Assets.xcassets"
            ballAnimation = super.retrieveAnimationImages(name: "Tball", numOfImages: 29);
        
        // numOfImages shown in the "apple animation" folder of "Assets.xcassets"
            appleAnimation = super.retrieveAnimationImages(name: "apple", numOfImages: 24);
        
        // numOfImages shown in the "bone animation" folder of "Assets.xcassets"
            boneAnimation = super.retrieveAnimationImages(name: "Bone", numOfImages: 46);
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(true)
        Narrator.setScriptWords(pageNumber: 1)
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


    /*  Name: initialiseAnimation(sceneImage, animation)
     
        Description: given a "sceneImage", get the appropriate animation images
                     with the apprpriate duration
     
     */
    
    

    /*  Name: playAnimation
     
        Description: given a tap gesture's view tag, show the associated animation for the
                     image that was tapped
    */
    
    override func playAnimation(_ sender: UITapGestureRecognizer) {
        switch sender.view!.tag {
        case 1:
            apple.frame = CGRect(x: 208, y: 307, width: 74, height: 1000)
            initialiseAnimation(sceneImage: apple, animation: appleAnimation)
            break
        case 2:
            initialiseAnimation(sceneImage: apple2, animation: appleAnimation)
            apple2.frame = CGRect(x: 31, y: 263, width: 74, height: 1000)
            break
        case 3:
            initialiseAnimation(sceneImage: apple3, animation: appleAnimation)
            apple3.frame = CGRect(x: 102, y: 92, width: 74, height: 1200)
            break
        case 4:
            initialiseAnimation(sceneImage: ball, animation: ballAnimation)
            break
        case 5:
            initialiseAnimation(sceneImage: bone, animation: boneAnimation)
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
