//
//  MainViewController.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 3/20/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var topHalf: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var bottomHalf: UIView!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let topFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 2)
        let bottomFrame = CGRect(x: 0, y: self.view.frame.height / 2, width: self.view.frame.width, height: self.view.frame.height / 2)
        topHalf.frame = topFrame
        bottomHalf.frame = bottomFrame
        
        loginButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y/2)
        registerButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y/2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

