//
//  UserData.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/27/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var user = UserData()
let db = Firestore.firestore()
let storage = Storage.storage() // reference to Firebase storage service

class UserData {
    //init
    var bookmarks: [Recipe]
    
    init() {
        bookmarks = [Recipe]()
        //get shit from firebase
        db.collection("bookmarks").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //let pathReference = storage.reference(withPath: "images/")
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    let name: String = document.data()["name"] as! String
                    let imgType: String = document.data()["imgType"] as! String
                    let id: Int = document.data()["id"] as! Int
                    let id_str = String(id)
                    let dict: [String: Any] = document.data()["dict"] as! [String: Any]
                    let pathReference = storage.reference(withPath: "images/\(id_str).jpg")
                    let imgRef = pathReference.child("images/\(id_str).jpg")
                    imgRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if error != nil {
                        print("Error")
                      } else {
                        let image: UIImage = UIImage(data: data!)!
                            let recipe = Recipe(name: name, picture: image, id: id, imgType: imgType, dict: dict)
                        self.bookmarks.append(recipe)
                      }
                    }
                }
            }
        }
    }
    
    func addBookmark(recipe: Recipe) {
        bookmarks.append(recipe)
//        var name: String
//        var picture: UIImage
//        var id: Int
//        var imgType: String
//        var dict: [String:Any]
        let imageID = String(recipe.id)
        let storageRef = storage.reference(withPath: "images/\(String(describing: imageID)).\(recipe.imgType)")
        guard let imageData = recipe.picture.jpegData(compressionQuality: 0.75) else { return }
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        storageRef.putData(imageData)
        
        var ref: DocumentReference? = nil
        
        ref = db.collection("bookmarks").addDocument(data: [
            "name" : recipe.name,
            "id" : recipe.id,
            "imgType" : recipe.imgType,
            "dict": recipe.dict
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
