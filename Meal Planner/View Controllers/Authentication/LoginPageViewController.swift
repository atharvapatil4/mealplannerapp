//
//  LoginPageViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/28/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit
class LoginPageViewController: UIViewController {
    
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
}

