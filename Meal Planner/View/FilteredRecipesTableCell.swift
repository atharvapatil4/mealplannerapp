//
//  filteredRecipesTableCell.swift
//  Meal Planner
//
//  Created by Emily Margis on 5/1/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit

class FilteredRecipesTableCell: UITableViewCell {
    static let identifier = "filteredRecipeCell"
    
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var recipeName: UILabel!
    @IBOutlet var placeholderView: UIView!
    
    
    override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          // Configure the view for the selected state
      }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        recipeImageView.image = nil
        recipeName.text?.removeAll()
    }
    
    func setUpCellLayout() {
        placeholderView.layer.cornerRadius = 5.0
        placeholderView.layer.masksToBounds = true
        placeholderView.backgroundColor = UIColor.white
        recipeImageView.contentMode = UIView.ContentMode.scaleAspectFill
//        self.layer.cornerRadius = 5.0
//        self.layer.masksToBounds = true
//        self.backgroundColor = UIColor.white
    }
}
