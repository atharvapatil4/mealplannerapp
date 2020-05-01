//
//  SignUpViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/28/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
class SignUpViewController: UIViewController {

    @IBOutlet var firstNameLabel: UITextField!
    @IBOutlet var lastNameLabel: UITextField!
    @IBOutlet var emailLabel: UITextField!
    @IBOutlet var passwordLabel: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    
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
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        // Validate fields
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            self.showError(error!)
            
        } else {
           
            // Create cleaned versions of the data
            let firstName = firstNameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid":result!.user.uid]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    //Transition to the home screen
                    self.transitionToExplore()
                }
            }
            // Transition to the home screen
        }
        
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToExplore() {
        
        let tabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UITabBarController
        
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
        
    }
}
