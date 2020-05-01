//
//  LoginViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/28/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet var emailLabel: UITextField!
    @IBOutlet var passwordLabel: UITextField!
    
    @IBOutlet var errorLabel: UILabel!
    
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(emailLabel)
        Utilities.styleTextField(passwordLabel)
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if emailLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
    
            return "Please fill in all fields."
        }
        return nil
    }
    
    override func viewDidLoad() {
        setUpElements()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        // Validate Text Fields
        let error = validateFields()
        if error != nil {
            // Show error message
            errorLabel.text = error
            errorLabel.alpha = 1
        }
        // Create cleaned versions of the text fields
        let email = emailLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    // Couldn't sign in
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else {
                    user.uid = result!.user.uid
                    // transition to home screen
                    let tabBarViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UITabBarController
                    
                    self.view.window?.rootViewController = tabBarViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
}
