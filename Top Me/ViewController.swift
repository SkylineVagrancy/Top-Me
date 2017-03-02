//
//  ViewController.swift
//  Top Me
//
//  Created by zhoujunpeng on 2017/2/28.
//  Copyright © 2017年 zhoujunpeng. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var scoreLable: UILabel!
    @IBOutlet var timeLable: UILabel!
    @IBOutlet var button: UIButton!
    
    var count = 0
    var seconds = 0
    var timer = Timer()
    
    var buttonBeep : AVAudioPlayer?
    var secondBeep : AVAudioPlayer?
    var backgroundMusic : AVAudioPlayer?
    
    func setupAudioPlayerWithFile(file:NSString,type:NSString) ->  AVAudioPlayer? {
        let path=Bundle.main.path(forResource: file as String, ofType: type as String)
        let url=NSURL.fileURL(withPath: path!)
        
        var audioPlayer : AVAudioPlayer?
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: url)
        }catch{
            print(" player is not available")
        }
        
        return audioPlayer
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let buttonBeep = self.setupAudioPlayerWithFile(file: "ButtonTap", type: "wav"){
            self.buttonBeep = buttonBeep;
        }
        if let secondBeep = self.setupAudioPlayerWithFile(file: "SecondBeep", type: "wav"){
            self.secondBeep = secondBeep;
        }
        if let backgroundMusic = self.setupAudioPlayerWithFile(file: "HallOfTheMountainKing", type: "mp3"){
            self.backgroundMusic = backgroundMusic;
        }
        
        setupGame()
        view.backgroundColor = UIColor(patternImage: UIImage(named:"bg_tile.png")!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(){
        buttonBeep?.play()
        count+=1
        scoreLable.text = "Score \n\(count)"
    }
    
    func setupGame(){
        backgroundMusic?.volume = 0.3
        backgroundMusic?.play()
        seconds = 30
        count=0
        timeLable.text = "Time: \(seconds)"
        scoreLable.text = "Score \(count)"
        timer = Timer.scheduledTimer(timeInterval: 1.0,target: self ,selector: #selector(ViewController.subtractTimer),userInfo: nil,repeats: true)
    }
    func subtractTimer(){
        secondBeep?.play()
        seconds -= 1
        timeLable.text = "Time: \(seconds)"
        if(seconds==0){
          timer.invalidate()
            let alter = UIAlertController(title: "Timer is up!", message: "Your scored \(count) points", preferredStyle: UIAlertControllerStyle.alert)
            alter.addAction(UIAlertAction(title: "Play again!", style: UIAlertActionStyle.default, handler: {action in self.setupGame()}))
            present(alter,animated: true,completion: nil)
            
        }
    }


}

