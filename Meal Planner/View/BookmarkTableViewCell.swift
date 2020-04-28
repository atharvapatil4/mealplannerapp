//
//  BookmarkTableViewCell.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/27/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit

class BookmarkTableViewCell: UITableViewCell {
    
    
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var recipeLabel: UILabel!
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }
}
