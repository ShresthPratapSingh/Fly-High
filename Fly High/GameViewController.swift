//
//  GameViewController.swift
//  Fly High
//
//  Created by Shresth Pratap Singh on 11/10/19.
//  Copyright © 2019 Shresth. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let welcomeScene = WelcomeScene(size: UIScreen.main.bounds.size)
        welcomeScene.scaleMode = .aspectFill
        
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.presentScene(welcomeScene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
