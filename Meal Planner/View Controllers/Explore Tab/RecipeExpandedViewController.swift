//
//  RecipeExpandedViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/22/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit

class RecipeExpandedViewController: UIViewController {
    // MARK: - Class Props/Vars
    var img: UIImage?
    var recipeName: String = ""
    var chosenRecipe: Recipe!
    
    // MARK: - IBOutlets
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var preparationTimeLabel: UILabel!
    @IBOutlet var calorieLabel: UILabel!
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var ingredientsLabel: UILabel!
    @IBOutlet var ingredientsBodyLabel: UILabel!
    @IBOutlet var directionsLabel: UILabel!
    @IBOutlet var directionsBodyLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "recipeExpandedToExplore", sender: sender)
    }
    @IBAction func bookmarkButtonPressed(_ sender: UIButton) {
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeNameLabel.text = chosenRecipe?.name
        recipeImage.image = chosenRecipe?.picture
        guard let preptime = chosenRecipe.dict["readyInMinutes"] as? Int else {return}
        preparationTimeLabel.text = String(preptime) + " minutes"
        
        guard let extendedIngredients = chosenRecipe.dict["extendedIngredients"] as? [[String:Any]] else {return}
        ingredientsBodyLabel.numberOfLines = 0
        ingredientsBodyLabel.preferredMaxLayoutWidth = 400
        ingredientsBodyLabel.text = ""
        print(extendedIngredients.count)
        for (ingredientDict) in extendedIngredients {
            //ingredientsBodyLabel.text = ""
            var amt = 0
            var unit = ""
            var name = ""
            if let currAmount = ingredientDict["amount"] as? Int {
                amt=currAmount
            }
            if let currUnit = ingredientDict["unit"] as? String {
                unit = currUnit
            }
            if let ingredientName = ingredientDict["name"] as? String {
                name = ingredientName
            }
            var ingredient = String(amt) + " " + unit + " " + name
            if (amt == 0) {
                ingredient = name
            }
            let unwrapped = ingredientsBodyLabel.text  ?? ""
            ingredientsBodyLabel.text = unwrapped + "\n - \(ingredient) "
            print(ingredient)
        }
        //ingredientsBodyLabel.sizeToFit()
        directionsBodyLabel.numberOfLines = 0
        directionsBodyLabel.preferredMaxLayoutWidth = 400
        directionsBodyLabel.text = ""
        let analyzedInstructions = chosenRecipe.dict["analyzedInstructions"] as? [[String:Any]]
        guard let steps = analyzedInstructions![0]["steps"] as? [[String:Any]] else {return}
        for (step) in steps {
            var number = ""
            var body = ""
            if let stepNumber = step["number"] as? Int {
                number = String(stepNumber) + ". "
            }
            if let stepBody = step["step"] as? String {
                body = stepBody
            }
            let stepMessage = number + body
            let unwrapped = directionsBodyLabel.text  ?? ""
            directionsBodyLabel.text = unwrapped + stepMessage + "\n"
        }
        print(directionsBodyLabel.text)
       //directionsBodyLabel.sizeToFit()
    }
    
}
