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
    
    
    override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          // Configure the view for the selected state
      }
    
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        //set the values for top,left,bottom,right margins
//                let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//        self.frame = self.frame.inset(by: margins)
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        recipeImageView.image = nil
        recipeName.text?.removeAll()
    }
}
