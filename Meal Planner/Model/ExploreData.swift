//
//  RecipeData.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/21/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit

var exploreData = ExploreData()

/**This class is for an entry in the CollectionView**/
class Recipe {
    var name: String
    var picture: UIImage
    var id: Int
    var imgType: String
    var dict: [String:Any]
    // also need some identifier for the API.
    // so onClick you can quickly retreive recipe info
    
    init(name: String, picture: UIImage, id: Int, imgType: String, dict: [String:Any]) {
        self.name = name
        self.picture = picture
        self.id = id
        self.imgType = imgType
        self.dict = dict
    }
    
}


struct RecipeRequest {
    let resourceURL: URL
    let API_KEY = "8b8a10a2cede413daffe571c0a5be321"
    let resourceString = "https://api.spoonacular.com/recipes/random?number=10&apiKey=8b8a10a2cede413daffe571c0a5be321"
    
}

public class ExploreData {
    enum State {
        case loading
       case loaded
    }
    var finishedLoading: Bool
    var key: String
    var urlString: String
    var recipeList: [Recipe]
    init() {
        finishedLoading = false
        recipeList = [Recipe]()
        //recipeList = [Recipe(name: "garbers", picture: UIImage(named: "garbers")!, id: 313, imgType: "jpg", dict: [String:Any]()), Recipe(name: "NYC", picture: UIImage(named: "skyline")!, id: 23, imgType: "jpg", dict: [String:Any]()), Recipe(name: "garbers", picture: UIImage(named: "garbers")!, id: 313, imgType: "jpg", dict: [String:Any]()), Recipe(name: "garbers", picture: UIImage(named: "garbers")!, id: 313, imgType: "jpg", dict: [String:Any]())]
        key = "8b8a10a2cede413daffe571c0a5be321"
        urlString = "https://api.spoonacular.com/recipes/random?number=10&apiKey=8b8a10a2cede413daffe571c0a5be321"
        //refresh()
        print("Done Initialization")
    }
    
    func refresh() {
//        defer {
//
//        }
        print("here0")
        guard let url = URL(string: urlString) else { fatalError("Error getting url") }
        print("here0.5")
        let sesh = URLSession.shared.dataTask(with: url) {(data, response, err) in
            print("here0.75")
            guard let recipeData = data else {return}
            print("here1")
            let json = try? JSONSerialization.jsonObject(with: recipeData, options: [])
            print("here2")
            guard let dictionary = json as? [String: Any] else {return}
            print("here3")
            //recipes -> id title image
            guard let recipes = dictionary["recipes"] as? [[String:Any]] else {return}
            print("here4")
            for (recipe) in recipes {
                print("here5")
                DispatchQueue.main.async {
                    
                    guard let id =  recipe["id"] as? Int else {return}
                    guard let img = recipe["image"] as? String else {return}
                    guard let title = recipe["title"] as? String else {return}
                    guard let imgType = recipe["imageType"] as? String else {return}
                    
                    let imgurl = URL(string: img)
                    if let data = try? Data(contentsOf: imgurl!)
                    {
                        let realImage: UIImage = UIImage(data: data)!
                        let toAdd = Recipe(name: title, picture: realImage, id: id, imgType: imgType, dict: recipe)
                        self.recipeList.append(toAdd)
                    }
                }
                
            }
            self.finishedLoading = true
        }
        sesh.resume()
    }
        

    //1. get 10 popular recipes

    //2. load the data into array of Recipe
    //3. init()
}
