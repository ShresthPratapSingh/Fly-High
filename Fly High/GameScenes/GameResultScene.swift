//
//  GameResultScene.swift
//  Fly High
//
//  Created by Shresth Pratap Singh on 13/10/19.
//  Copyright © 2019 Shresth. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GameResultScene:SKScene{
    var score:SKLabelNode
    var userHighest:SKLabelNode
    var gameHighest:SKLabelNode
    var correctSubmissions:SKLabelNode
    override init(size: CGSize) {
        score = SKLabelNode(text: "Score : \(DataModel.submissionResponseFromServer.score)")
        userHighest = SKLabelNode(text: "User Highest : \(DataModel.submissionResponseFromServer.user_highest_score)")
        gameHighest = SKLabelNode(text: "Game Highest : \(DataModel.submissionResponseFromServer.game_highest_score)")
        correctSubmissions = SKLabelNode(text: "Correct :\(DataModel.submissionResponseFromServer.correctly_attempted)")
        
        super.init(size: size)
        backgroundColor = Constants.LIGHT_BLUE
        
        score.fontName = "DoubleDecker DEMO"
        score.fontColor = .red
        score.fontSize = 30
        score.zPosition = 10
        score.position = CGPoint(x: Constants.SCREEN_SIZE.width/2, y: Constants.SCREEN_SIZE.height - 100)
        
        
        userHighest.fontName = "DoubleDecker DEMO"
        userHighest.fontSize = 30
        userHighest.zPosition = 10
        userHighest.fontColor = .red
        userHighest.position = CGPoint(x: Constants.SCREEN_SIZE.width/2, y: Constants.SCREEN_SIZE.height - 170)
        
        gameHighest.fontName = "DoubleDecker DEMO"
        gameHighest.fontSize = 30
        gameHighest.zPosition = 10
        gameHighest.fontColor = .red
        gameHighest.position = CGPoint(x: Constants.SCREEN_SIZE.width/2, y: Constants.SCREEN_SIZE.height - 240)
        
        correctSubmissions.fontName = "DoubleDecker DEMO"
        correctSubmissions.fontSize = 30
        correctSubmissions.zPosition = 10
        correctSubmissions.fontColor = .red
        correctSubmissions.position = CGPoint(x: Constants.SCREEN_SIZE.width/2, y: Constants.SCREEN_SIZE.height - 310)
        
        addChild(score)
        addChild(userHighest)
        addChild(gameHighest)
        addChild(correctSubmissions)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
