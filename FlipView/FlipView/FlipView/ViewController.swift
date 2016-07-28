//
//  ViewController.swift
//  FlipView
//
//  Created by 潘东 on 16/7/28.
//  Copyright © 2016年 潘东. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let flipView = FlipView()
    private var timer: NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.lightGrayColor()
        setFlipView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setFlipView() {
        self.view.addSubview(flipView)
        flipView.frame = CGRect(x: 125, y: 100, width: 100, height: 100)
        
        flipView.primaryView.image = UIImage(named: "surfingCamp")
        flipView.secondaryView.image = UIImage(named: "pokemon2")
        startFlip()
    }
    
    func startFlip() {
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(self.flipTheView), userInfo: nil, repeats: true)
    }
    
    func flipTheView() {
        flipView.flip()
    }
}

