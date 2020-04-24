//
//  LoadingViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/23/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
    }
}
