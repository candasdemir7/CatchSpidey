//
//  ViewController.swift
//  CatchSpidey
//
//  Created by Can Daşdemir on 15.03.2024.
//
//

import UIKit

class ViewController: UIViewController {
    
    
    //variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var spideyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score \(score)"
        
        
        //high score check
        
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        
        
        spidey1.isUserInteractionEnabled = true
        spidey2.isUserInteractionEnabled = true
        spidey3.isUserInteractionEnabled = true
        spidey4.isUserInteractionEnabled = true
        spidey5.isUserInteractionEnabled = true
        spidey6.isUserInteractionEnabled = true
        spidey7.isUserInteractionEnabled = true
        spidey8.isUserInteractionEnabled = true
        spidey9.isUserInteractionEnabled = true
       

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        spidey1.addGestureRecognizer(recognizer1)
        spidey2.addGestureRecognizer(recognizer2)
        spidey3.addGestureRecognizer(recognizer3)
        spidey4.addGestureRecognizer(recognizer4)
        spidey5.addGestureRecognizer(recognizer5)
        spidey6.addGestureRecognizer(recognizer6)
        spidey7.addGestureRecognizer(recognizer7)
        spidey8.addGestureRecognizer(recognizer8)
        spidey9.addGestureRecognizer(recognizer9)
        
        
        spideyArray = [spidey1, spidey2, spidey3, spidey4, spidey5, spidey6, spidey7, spidey8, spidey9]
        
        
        //timer
        
        counter = 10
        timeLabel.text = "Hurry Up! \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideSpidey), userInfo: nil, repeats: true)

        
        
        //background
        
            assignbackground()
        
    
            hideSpidey()

        
    }
    
    
    
    @objc func hideSpidey(){
        
        for spidey in spideyArray{
            spidey.isHidden = true
        }
        //random number
        let random = Int( arc4random_uniform(UInt32(spideyArray.count - 1)))
        spideyArray[random].isHidden = false
        
        
        
    }
    
    
    
    func assignbackground(){
        

            let background = UIImage(named: "wallpaper")
            var imageView : UIImageView!
            imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  UIView.ContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = background
            imageView.center = view.center
            view.addSubview(imageView)
            self.view.sendSubviewToBack(imageView)
        }
    
    //timer func
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = "Hurry Up! \(counter)"
        
        if counter == 0 {
            
            timer.invalidate()
            hideTimer.invalidate()
            
            for spidey in spideyArray{
                spidey.isHidden = true
            }
            
            
            //highscore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to catch Spidey again?", preferredStyle: UIAlertController.Style.alert)
            
            let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)

            let replayBtn = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = "Hurry Up! \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hideSpidey), userInfo: nil, repeats: true)
                
                
            }
            
            
            alert.addAction(okBtn)
            alert.addAction(replayBtn)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        

    }
    
    
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    

    @IBOutlet weak var spidey1: UIImageView!
    @IBOutlet weak var spidey2: UIImageView!
    @IBOutlet weak var spidey4: UIImageView!
    @IBOutlet weak var spidey5: UIImageView!
    @IBOutlet weak var spidey6: UIImageView!
    @IBOutlet weak var spidey7: UIImageView!
    @IBOutlet weak var spidey8: UIImageView!
    @IBOutlet weak var spidey9: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var spidey3: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
}

