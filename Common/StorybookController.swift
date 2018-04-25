//
//  NavigationController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 19/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit;
import SpriteKit;

class StorybookController: UIViewController{
    
    // Navigation
//        var navLeftButton = SKSpriteNode(imageNamed: "nav-button_left");
//        var navRightButton = SKSpriteNode(imageNamed: "nav-button_right");

//        var narratorButton = SKSpriteNode(imageNamed: "narratorsound-button_on")
//        var MusicButton = SKSpriteNode(imageNamed: "sound-button_on")
    // Graphical Settings
//        var musicBtnImage: UIImage?
//        var narratorSoundBtnImage: UIImage?
    @IBOutlet weak var backgroundMusicBtn: UIButton!
    @IBOutlet weak var narratorSoundBtn: UIButton!
    
    override func viewDidLoad() {
        if(MusicPlayer.isSetup == false) {
            MusicPlayer.setup();
            MusicPlayer.isSetup = true;
        }
    }
    
    func updateMusicBtnImage() {
            if(MusicPlayer.getMusicState() == true) {
               backgroundMusicBtn.setBackgroundImage(UIImage(named: "sound-button_on"), for: .normal);
            }
            else {
                backgroundMusicBtn.setBackgroundImage(UIImage(named: "sound-button_off"), for: .normal);
            }
    }
    
    func updateNarrationBtnImage() {
        if(MusicPlayer.getNarrationState() == true) {
             narratorSoundBtn.setBackgroundImage(UIImage(named: "narrator-sound-button_on"), for: .normal);
        }
        else {
            narratorSoundBtn.setBackgroundImage(UIImage(named: "narrator-sound-button_off"), for: .normal);
        }
    }
    
    @IBAction func changeMusicSetting(_ sender: Any) {
        MusicPlayer.toggleMusic();
        updateMusicBtnImage();
    }
    
    @IBAction func changeNarrationSetting(_ sender: Any) {
        MusicPlayer.toggleNarration();
        updateNarrationBtnImage();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//
    // Exit
//        var exitButton = SKSpriteNode(imageNamed: "exit-button_small")
}
