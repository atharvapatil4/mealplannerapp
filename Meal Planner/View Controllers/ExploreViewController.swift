//
//  ViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/21/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//
import Foundation
import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreData.recipeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let recipe = exploreData.recipeList[index]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as? RecommendedCollectionViewCell {
            cell.recipeLabel.text = recipe.name
            //fill entire image view
            cell.recipeImageView.image = recipe.picture
            cell.recipeImageView.contentMode = UIView.ContentMode.scaleAspectFill
            print("finished cell")
            return cell
        } else {
            print("finished blank cell")
            return UICollectionViewCell()
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // segue to preview controller with selected thread
        if let chosenRecipe = exploreData.recipeList[indexPath.item] as Recipe? {
            print(chosenRecipe)
            performSegue(withIdentifier: "exploreToRecipeExpanded", sender: chosenRecipe)
        }
            //perform segue with sender chosenThread
        
    
       }
    
    override func viewWillAppear(_ animated: Bool) {
    
        recommendedCollectionView.reloadData()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "exploreToRecipeExpanded" {
                if let dest = segue.destination as? RecipeExpandedViewController, let chosenRecipe = sender as? Recipe {
                    dest.chosenRecipe = chosenRecipe
                }
            }
        }
    }
    
    //OUTLETS
    @IBOutlet var recommendedCollectionView: UICollectionView!
    @IBOutlet var searchforRecipe: UITextField!
    //ACTIONS
    @IBAction func popularButtonPressed(_ sender: UIButton) {
    }
    @IBAction func vegetarianButtonpressed(_ sender: Any) {
    }
    @IBAction func balancedButtonPressed(_ sender: Any) {
    }
    @IBAction func lowcarbButtonPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
    
        defer {
            super.viewDidLoad()
            recommendedCollectionView.delegate = self
            recommendedCollectionView.dataSource = self
            print(exploreData.recipeList)
        }
        
        exploreData.refresh()
        
        // Do any additional setup after loading the view.
    }


}

