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
    
    // MARK: - Outlets
    @IBOutlet var recommendedCollectionView: UICollectionView!
    @IBOutlet var searchforRecipe: UITextField!
    @IBOutlet weak var TitleLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func popularButtonPressed(_ sender: UIButton) {
    }
    @IBAction func vegetarianButtonpressed(_ sender: Any) {
    }
    @IBAction func balancedButtonPressed(_ sender: Any) {
    }
    @IBAction func lowcarbButtonPressed(_ sender: Any) {
    }
    
    
    func fetchRecipes() {
        guard let url = URL(string: exploreData.urlString) else { fatalError("Error getting url") }
        
            let sesh = URLSession.shared.dataTask(with: url) {(data, response, err) in
                guard let recipeData = data else {return}
                let json = try? JSONSerialization.jsonObject(with: recipeData, options: [])
                guard let dictionary = json as? [String: Any] else {return}
                //recipes -> id title image
                guard let recipes = dictionary["recipes"] as? [[String:Any]] else {return}
                for (recipe) in recipes {
                        if let instructions = recipe["analyzedInstructions"] as? [[String:Any]] {
                            if (instructions.isEmpty) {
                                continue
                            }
                        }
                        guard let id =  recipe["id"] as? Int else {return}
                        guard let img = recipe["image"] as? String else {return}
                        guard let title = recipe["title"] as? String else {return}
                        guard let imgType = recipe["imageType"] as? String else {return}
                        
                        let imgurl = URL(string: img)
                        if let data = try? Data(contentsOf: imgurl!)
                        {
                            let realImage: UIImage = UIImage(data: data)!
                            let toAdd = Recipe(name: title, picture: realImage, id: id, imgType: imgType, dict: recipe)
                            exploreData.recipeList.append(toAdd)
                            DispatchQueue.main.async {
                                self.recommendedCollectionView.reloadData()
                            }
                        }
                    
                }
                exploreData.finishedLoading = true
            }
            sesh.resume()
    }
    // MARK: - Methods
    override func viewDidLoad() {
        
            super.viewDidLoad()
            recommendedCollectionView.delegate = self
            recommendedCollectionView.dataSource = self
        
        fetchRecipes()
        
        
        // Do any additional setup after loading the view.
    }
    
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
            cell.layer.cornerRadius = 5.0
            cell.layer.masksToBounds = true
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
    
    


}

