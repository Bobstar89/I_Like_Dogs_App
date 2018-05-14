//
//  ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 10/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit;

class MainViewController: StorybookController {
    @IBOutlet weak var growingReadersAndWritersBtn: UIButton!
    @IBOutlet weak var emergentLiteracyAssessmentBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        super.updateMusicBtnImage();
        super.updateNarrationBtnImage();
        
        if(MusicPlayer.isSetup == false) {
            
            /* set up music player in MusicPlayer.swift */
                MusicPlayer.setup();
        }
        
        growingReadersAndWritersBtn.tag = 1;
        emergentLiteracyAssessmentBtn.tag = 2;
    }
        
    @IBAction func linkToExternalResource(_ sender: UIButton) {
        var resourceURL: URL!
        
        print(sender.tag)
        switch sender.tag {
            // case GrowingReadersAndWritersBtn pressed
        case 1:
            resourceURL = URL(string: "http://growingreadersandwriters.com");
            break;
        case 2:
            resourceURL = URL(string: "itms://itunes.apple.com/au/app/elaa-emergent-literacy-assessment/id1090637340?mt=8");
            break;
        default:
            print("button not assigned to this number");
        }
        
        UIApplication.shared.open(resourceURL);
    }
    //        if(audioSystem == nil) {
//            audioSystem = MusicPlayer()
//        }
        // Do any additional setup after loading the view, typically from a nib.

}

 
