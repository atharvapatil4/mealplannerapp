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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeNameLabel.text = chosenRecipe?.name
        recipeImage.image = chosenRecipe?.picture
        guard let preptime = chosenRecipe.dict["readyInMinutes"] as? Int else {return}
        preparationTimeLabel.text = String(preptime) + " minutes"
        
        guard let extendedIngredients = chosenRecipe.dict["extendedIngredients"] as? [[String:Any]] else {return}
        ingredientsBodyLabel.preferredMaxLayoutWidth = 150
        for (ingredientDict) in extendedIngredients {
            //ingredientsBodyLabel.text = ""
            guard let amt = ingredientDict["amount"] as? Int else {return}
            guard let unit = ingredientDict["unit"] as? String else {return}
            guard let ingredientName = ingredientDict["name"] as? String else {return}
            let ingredient = String(amt) + " " + unit + " " + ingredientName
            let unwrapped = ingredientsBodyLabel.text  ?? ""
            ingredientsBodyLabel.text = unwrapped + "\(ingredient) "
            print(ingredient)
        }
        //ingredientsBodyLabel.sizeToFit()
        directionsBodyLabel.text = chosenRecipe.dict["instructions"] as? String
        print(directionsBodyLabel.text)
       //directionsBodyLabel.sizeToFit()
    }
    
}
