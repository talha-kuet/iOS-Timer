//
//  ViewController.swift
//  iOS Timer
//
//  Created by Mazegeek Mac Mini 2018 on 12/3/19.
//  Copyright © 2019 Mazegeek Mac Mini 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    var timer: Timer?
    var displayLink: CADisplayLink?
    var isStarted = false
    
    var runCount = 0 {
        didSet {
            countdownLabel.text = "\(runCount)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createTimer()
    }
    
    func createTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timer?.tolerance = 0.2
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    @objc func fireTimer() {
        print("Timer Fired")
        
        runCount += 1
        
        if runCount == 3 {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func fireCADisplayLink() {
        
        runCount += 1
        print("CADisplayLink Called ==>> \(runCount)")
        
    }
    
    //MARK:- IBActions
    
    @IBAction func startStopButtonAction(_ sender: UIButton) {
        
        isStarted = !isStarted
        
        if isStarted {
            startStopButton.setTitle("Stop Timer", for: .normal)
            startStopButton.backgroundColor = .systemPink
            
            displayLink = CADisplayLink(target: self, selector: #selector(fireCADisplayLink))
            displayLink?.preferredFramesPerSecond = 6
            displayLink?.add(to: .main, forMode: .common)
        }
        else {
            startStopButton.setTitle("Start Timer", for: .normal)
            startStopButton.backgroundColor = UIColor(red: 27/255, green: 204/255, blue: 133/255, alpha: 1)
            
            displayLink?.remove(from: .main, forMode: .common)
            displayLink = nil
            
            
        }
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        
        runCount = 0
        
        if isStarted == true {
            isStarted = false
            
            startStopButton.setTitle("Start Timer", for: .normal)
            startStopButton.backgroundColor = UIColor(red: 27/255, green: 204/255, blue: 133/255, alpha: 1)
            
            displayLink?.remove(from: .main, forMode: .common)
            displayLink = nil
        }
    }
}

