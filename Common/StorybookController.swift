//
//  NavigationController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 19/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit;

    /*
                              ==========================
                                 STORYBOOK CONTROLLER
                              ==========================
 
                        Storyboard controller is used to change
                        child view elements and give views their
                        required animation.
 
                        The class also interfaces with the Music
                        Player to reflect the correct audio button
                        toggles.
     */

class StorybookController: UIViewController{
 
    @IBOutlet weak var backgroundMusicBtn: UIButton!
    @IBOutlet weak var narratorSoundBtn: UIButton!
    @IBOutlet weak var growingRandWBtn: UIButton!
    
    private var animationSpeedInSeconds = 0.033;
    
    /*  Name: updateMusicBtnImage()
    
        Description: changes the background music button to reflect the Music Player's isMusicOn state
            
        Used By: changeMusicSetting()
     
        Dependencies: MusicPlayer.getMusicState(), backgroundMusicBtn
    */
    

    func updateMusicBtnImage() {
            if(MusicPlayer.getMusicState() == true) {
                backgroundMusicBtn.setBackgroundImage(UIImage(named: "sound-button_on"), for: .normal);
            }
            else {
                backgroundMusicBtn.setBackgroundImage(UIImage(named: "sound-button_off"), for: .normal);
            }
    }
    
    /*  Name: updateNarrtionBtnImage()
     
        Description: changes the background music button to reflect the Music Player's isNarrationOn state
     
        Used By: changeNarrationSetting()
     
        Dependencies: MusicPlayer.getMusicState(), narrationSoundBtn
    */
    
    func updateNarrationBtnImage() {
        if(MusicPlayer.getNarrationState() == true) {
             narratorSoundBtn.setBackgroundImage(UIImage(named: "narrator-sound-button_on"), for: .normal);
        }
        else {
            narratorSoundBtn.setBackgroundImage(UIImage(named: "narrator-sound-button_off"), for: .normal);
        }
    }
    
    func updateText(text: String) -> CATextLayer {
        let wordHighlightProperties = CATextLayer()
        
        if(text != "I") {
            wordHighlightProperties.string = text.lowercased();
        }
        else {
            wordHighlightProperties.string = text
        }
        wordHighlightProperties.fontSize = 40
        wordHighlightProperties.foregroundColor = UIColor.white.cgColor
        return wordHighlightProperties
    }
    
    func highlightWord(word: String, duration: Double, atTime: Double) {
        UIView.animate(withDuration: duration, delay: atTime, animations: {
            
        })
    }
    
    func initialiseAnimation(sceneImage: UIImageView, animation: [UIImage]) {
        sceneImage.image = animation.first
        sceneImage.animationImages = animation;
        sceneImage.animationDuration = getFramesPerSecond(numOfFrames: animation.count);
        sceneImage.animationRepeatCount = 1;
        sceneImage.startAnimating();
        sceneImage.image = animation.last
    }
    
    /*  Name: playAnimation()
 
        Description: This method will be overriden by child elements to play page specific animations
    */
    
    @objc func playAnimation(_ sender: UITapGestureRecognizer) {
        
    }
    
    /*  Name: setupAnimationTapRecognition()
 
        Description: create a tap recognizer that is used by a UIImage from the function caller
     */
    func setupAnimationTapRecognition() -> UITapGestureRecognizer{
        let pageTapRecognizer =  UITapGestureRecognizer(target: self, action: #selector(self.playAnimation(_:)))
        
        return pageTapRecognizer;
    }
    
    /*  Name: getFramesPerSecond(numOfFrames)
 
        Description: given the number of frames in an animation, multiply it by the standard
                     animation speed and give the result to the function caller
      */
    
    func getFramesPerSecond(numOfFrames: Int) -> Double {
        return animationSpeedInSeconds * (Double)(numOfFrames);
    }
    
    /*  Name: retrieveAnimationImages(name, numOfImages)
     
        Description: given the name of the object to animate, find the animation
                     images in the "Assets.xcassets" folder and give the calling
                     function an array containing the animation images
     */

    func retrieveAnimationImages(name: String, numOfImages: Int) -> [UIImage]{
        
        var newAnimArray = [UIImage]();

        for i in 0 ... numOfImages{
            newAnimArray.append(UIImage(named: "\(name)\(i).png")!);
        }

        return newAnimArray;
    }
    
    /*  Name: changeMusicSetting()
 
     Description: On clicking the "backgroundMusicBtn", Using "toggleMusic"
                  from the "MusicPlayer", switch the audio on or off
                  depending on the current setting and change the music
                  button to reflect this change
     */
    @IBAction func goToNextPage(_ sender: Any) {
//        MusicPlayer.playButtonSoundEffect();
    }
    
    @IBAction func changeMusicSetting(_ sender: Any) {
        MusicPlayer.toggleMusic();
        updateMusicBtnImage();
    }
    
    /*  Name: changeNarrationSetting()
     
        Description: On clicking the "narrationSoundBtn", Using "toggleMusic"
                     from the "MusicPlayer", switch the audio on or off
                     depending on the current setting and change the music
                     button to reflect this change
     
        Dependencies: MusicPlayer
     */
    @IBAction func changeNarrationSetting(_ sender: Any) {
        MusicPlayer.toggleNarration();
        updateNarrationBtnImage();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dispatchTester(_ sender: Any) {
        MusicPlayer.dispatchAudio()
    }
}
