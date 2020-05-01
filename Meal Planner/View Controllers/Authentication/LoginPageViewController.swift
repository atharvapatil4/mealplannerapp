//
//  LoginPageViewController.swift
//  Meal Planner
//
//  Created by Atharva Patil on 4/28/20.
//  Copyright © 2020 Atharva and Emily. All rights reserved.
//

import Foundation
import UIKit
import AVKit
class LoginPageViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Set up video in the background
        setUpVideo()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setUpVideo() {
        
        // Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "tomatoes", ofType: "mp4")
        guard bundlePath != nil else {
            return
        }
        
        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        // Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.5)
    }
}

