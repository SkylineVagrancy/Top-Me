//
//  ViewController.swift
//  Top Me
//
//  Created by zhoujunpeng on 2017/2/28.
//  Copyright © 2017年 zhoujunpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scoreLable: UILabel!
    @IBOutlet var timeLable: UILabel!
    @IBOutlet var button: UIButton!
    
    var count = 0
    var seconds = 0
    var timer = Timer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(){
        count+=1
        scoreLable.text = "Score \n\(count)"
    }
    
    func setupGame(){
        seconds = 30
        count=0
        timeLable.text = "Time: \(seconds)"
        scoreLable.text = "Score \(count)"
        timer = Timer.scheduledTimer(timeInterval: 1.0,target: self ,selector: #selector(ViewController.subtractTimer),userInfo: nil,repeats: true)
    }
    func subtractTimer(){
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

