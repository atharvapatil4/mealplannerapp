//
//  ViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/21/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//
import Foundation
import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Outlets
    @IBOutlet var recommendedCollectionView: UICollectionView!
    @IBOutlet var searchforRecipe: UITextField!
    @IBOutlet weak var TitleLabel: UILabel!
//    @IBOutlet weak var filteredTableView: UITableView!
    @IBOutlet weak var filteredTableView: UITableView!
    
    // MARK: - Actions

   @IBAction func breakfastButtonPressed(_ sender: UIButton) {
       let tag = "breakfast"
       fetchFilteredRecipes(tag: tag)
   }
    
    @IBAction func desertButtonPressed(_ sender: UIButton) {
        
        let tag = "desert"
        fetchFilteredRecipes(tag: tag)
    }
    @IBAction func chineseButtonPressed(_ sender: UIButton) {
        let tag = "Chinese"
        fetchFilteredRecipes(tag: tag)
    }
    @IBAction func vegetarianButtonPressed(_ sender: UIButton) {
        let tag = "Vegetarian"
        fetchFilteredRecipes(tag: tag)
    }
    
    
    
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return exploreData.filteredRecipeList.count
        }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "filteredRecipeCell", for: indexPath) as? FilteredRecipesTableCell {
            let recipe = exploreData.filteredRecipeList[indexPath.row]
            cell.recipeName.text = recipe.name
            
            if let image = recipe.picture as? UIImage {
                cell.recipeImageView.image = image
            }
            cell.setUpCellLayout()
//            cell.recipeImageView.contentMode = UIView.ContentMode.scaleAspectFill
//            cell.layer.cornerRadius = 5.0
//            cell.layer.masksToBounds = true
//            cell.backgroundColor = UIColor.white
            return cell
        } else {
            return UITableViewCell()
        }
    }
        
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        
        filteredTableView.delegate = self
        filteredTableView.dataSource = self
        
        // Set navigation bar to be invisible
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        fetchRecipes()
        fetchFilteredRecipes(tag: "breakfast")
        // Do any additional setup after loading the view.
    }
    
    func fetchFilteredRecipes() {
        self.filteredTableView.reloadData()
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
    
    func fetchFilteredRecipes(tag :String) {
        let urlString = "https://api.spoonacular.com/recipes/random?number=20&tags=\(tag)&apiKey=\(exploreData.emilyKey)"
        guard let url = URL(string: urlString) else { fatalError("Error getting url") }
        print("FETCH FILTERED RECIPES URLSTRING: " + urlString)
            let sesh = URLSession.shared.dataTask(with: url) {(data, response, err) in
                guard let recipeData = data else {return}
                let json = try? JSONSerialization.jsonObject(with: recipeData, options: [])
                guard let dictionary = json as? [String: Any] else {return}
                //recipes -> id title image
                guard let recipes = dictionary["recipes"] as? [[String:Any]] else {return}
                exploreData.filteredRecipeList = [Recipe]()
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
                            exploreData.filteredRecipeList.append(toAdd)
                            print("ABOUT TO RELOAD DATA")
                            DispatchQueue.main.async {
                                self.filteredTableView.reloadData()
                            }
                        }
                }
                print("FILTERED RECIPE LIST AFTER FETCH: ", exploreData.filteredRecipeList)
                exploreData.finishedLoading = true
            }
            sesh.resume()
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
    

    override func viewWillAppear(_ animated: Bool) {
        filteredTableView.reloadData()
        recommendedCollectionView.reloadData()
       
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Preparing segue from ExploreData to Recipe Expanded")
        print(sender ?? "no sender")
        super.prepare(for: segue, sender:sender)
        if segue.identifier == "exploreFilteredToRecipeExpanded" {
            if let destination = segue.destination as? RecipeExpandedViewController, let index = filteredTableView.indexPathForSelectedRow?.item {
                destination.chosenRecipe = exploreData.filteredRecipeList[index]
            }
        }
        else if segue.identifier == "exploreToRecipe" {
            if let destination = segue.destination as?
                RecipeExpandedViewController, let index =
                recommendedCollectionView.indexPathsForSelectedItems?.first {
                destination.chosenRecipe = exploreData.recipeList[index.row]
            }
        }
    }
    
    


}

