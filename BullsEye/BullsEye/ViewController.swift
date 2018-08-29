//
//  ViewController.swift
//  BullsEye
//
//  Created by SrearAlex on 2017/1/4.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue = 0
    var score = 0
    var round = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNewRound()
        updateLabels()
        
//        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
//        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")

        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
//        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
//        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
//        var difference: Int
//        if currentValue > targetValue {
//            difference = currentValue - targetValue
//        } else if currentValue < targetValue {
//            difference = targetValue - currentValue
//        }/* else {
//            difference = 0
//        }*/
        /*
        var difference = targetValue - currentValue
        if difference < 0 {
            difference *= -1
        }
        */
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        
        let title: String
        if difference == 0 {
            title = "完美！"
            points += 100
        } else if difference < 5 {
            title = "就差一点点儿！"
            points += 50
        } else if difference < 10 {
            title = "很棒了！"
        } else {
            title = "可以更近点儿……"
        }
        score += points

//        let message = "现在滑块的位置为： \(currentValue) \n目标位置是： \(targetValue)"
        let message = "你的得分为： \(points)分"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default, handler: { action in
            self.startNewRound()
            self.updateLabels()
        })
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
//        startNewRound()
//        updateLabels()
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
//        print("滑块当前位置的值为：\(slider.value)")
        currentValue = lroundf(slider.value)
    }
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
    }
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(50)
    }
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
}

/*
 方法是一种函数
 方法为对象提供功能，帮助对象实现功能
 对象包含数值和功能
 */
