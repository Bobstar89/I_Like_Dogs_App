//
//  P8ViewController.swift
//  I Like Dogs
//
//  Created by Bobby Tagget on 12/4/18.
//  Copyright © 2018 Bobby Tagget. All rights reserved.
//

import UIKit

class EighthPageController: StorybookController{
    let storybookPageNumber = 8
    
    @IBOutlet weak var But: UILabel!
    @IBOutlet weak var Most: UILabel!
    @IBOutlet weak var Of: UILabel!
    @IBOutlet weak var All: UILabel!
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var Like: UILabel!
    @IBOutlet weak var My: UILabel!
    @IBOutlet weak var Dog: UILabel!
    
    var pageText = [UILabel]()
    
    override func viewDidLoad() {
        super.updateMusicBtnImage();
        super.updateNarrationBtnImage();
        
        Narrator.setScriptAudio(pageNumber: storybookPageNumber)
        
        But.text = ""
        Most.text = ""
        Of.text = ""
        All.text = ""
        I.text = ""
        Like.text = ""
        My.text = ""
        Dog.text = ""

        pageText.append(But)
        pageText.append(Most)
        pageText.append(Of)
        pageText.append(All)
        pageText.append(I)
        pageText.append(Like)
        pageText.append(My)
        pageText.append(Dog)
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

}
