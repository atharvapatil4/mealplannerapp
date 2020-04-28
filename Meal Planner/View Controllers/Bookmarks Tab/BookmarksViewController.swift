//
//  BookmarksViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/27/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class BookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var bookmarksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookmarksTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.item
        let recipe = user.bookmarks[index]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as? BookmarkTableViewCell {
            // configure cell
            cell.recipeImageView.image = recipe.picture
            cell.recipeLabel.text = recipe.name
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let chosenRecipe = user.bookmarks[indexPath.item] as Recipe? {
                   print(chosenRecipe)
                   performSegue(withIdentifier: "bookmarksToRecipeExpanded", sender: chosenRecipe)
               }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "bookmarksToRecipeExpanded" {
                if let dest = segue.destination as? RecipeExpandedViewController, let chosenRecipe = sender as? Recipe {
                    dest.chosenRecipe = chosenRecipe
                }
            }
        }
    }
    
    
}
