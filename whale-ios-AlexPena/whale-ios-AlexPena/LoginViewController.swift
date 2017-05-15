//
//  LoginViewController.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 3/26/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import UIKit
import Foundation

class LoginViewControler: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: Any) {
        APIWrapper.login()
        
        if KeychainWrapper.userIsAuthenticated() {
//            APIWrapper.getAnswers() { answersJSON in
//                
//            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            if let window = appDelegate.window {
                window.rootViewController = initialViewController
            }
        }
    }
}
