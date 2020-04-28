//
//  SignUpViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/28/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit
class SignUpViewController: UIViewController {

    @IBOutlet var firstNameLabel: UITextField!
    @IBOutlet var lastNameLabel: UITextField!
    @IBOutlet var emailLabel: UITextField!
    @IBOutlet var passwordLabel: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameLabel)
        Utilities.styleTextField(lastNameLabel)
        Utilities.styleTextField(emailLabel)
        Utilities.styleTextField(passwordLabel)
    }
}
