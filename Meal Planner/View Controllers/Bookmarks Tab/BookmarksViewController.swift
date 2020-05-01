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
        fetchBookmarks()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as?
        RecipeExpandedViewController, let index =
        bookmarksTableView.indexPathForSelectedRow?.first {
        destination.chosenRecipe = exploreData.recipeList[index]
        }
    }
    
    func fetchBookmarks() {
        db.collection("bookmarks")
            .document(user.uid!)
            .getDocument { (document, error) in
            // Check for error
            if error == nil {
                // Check that this document exists
                if document != nil && document!.exists {
                    let bookmarkList = document!.data()!["bookmarkList"] as! [[String:Any]]
                    for (bookmark) in bookmarkList {
                        if (bookmark.isEmpty) {
                            continue
                        }
                        let name: String = bookmark["name"] as! String
                        let imgType: String = bookmark["imgType"]  as! String
                        let id: Int = bookmark["id"]  as! Int
                        let id_str = String(id)
                        let dict: [String: Any] = bookmark["dict"]  as! [String: Any]
                        let pathReference = storage.reference(withPath: "images/")
                        let imgRef = pathReference.child("\(id_str).jpg")
                        imgRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                            if error != nil {
                            print("Error")
                          } else {
                            let image: UIImage = UIImage(data: data!)!
                                let recipe = Recipe(name: name, picture: image, id: id, imgType: imgType, dict: dict)
                            user.bookmarks.append(recipe)
                                var dic: [String: Any] = [:]
                                dic["name"] = recipe.name
                                dic["id"] = recipe.id
                                dic["imgType"] = recipe.imgType
                                dic["dict"] = recipe.dict
                                user.uploadList.append(dic)
                                DispatchQueue.main.async {
                                    self.bookmarksTableView.reloadData()
                                }
                          }
                        }
                    }
                    
                }
                
            }
            
        }
//        db.collection("bookmarks").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//
//                //let pathReference = storage.reference(withPath: "images/")
//                for document in querySnapshot!.documents {
//                    //print("\(document.documentID) => \(document.data())")
//                    let name: String = document.data()["name"] as! String
//                    let imgType: String = document.data()["imgType"] as! String
//                    let id: Int = document.data()["id"] as! Int
//                    let id_str = String(id)
//                    let dict: [String: Any] = document.data()["dict"] as! [String: Any]
//                    let pathReference = storage.reference(withPath: "images/")
//                    let imgRef = pathReference.child("\(id_str).jpg")
//                    imgRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                        if error != nil {
//                        print("Error")
//                      } else {
//                        let image: UIImage = UIImage(data: data!)!
//                            let recipe = Recipe(name: name, picture: image, id: id, imgType: imgType, dict: dict)
//                        user.bookmarks.append(recipe)
//                            let lst = [name, id, imgType, dict] as [Any]
//                            user.uploadList.append(lst)
//                            DispatchQueue.main.async {
//                                self.bookmarksTableView.reloadData()
//                            }
//                      }
//                    }
//                }
//            }
//        }
    }
}
