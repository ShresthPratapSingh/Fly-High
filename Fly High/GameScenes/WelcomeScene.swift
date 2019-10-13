//
//  GameScene.swift
//  Fly High
//
//  Created by Shresth Pratap Singh on 11/10/19.
//  Copyright © 2019 Shresth. All rights reserved.
//


import SpriteKit
import GameplayKit

class WelcomeScene: SKScene {
    
    let background : SKSpriteNode
    let mountains: SKSpriteNode
    let balloonOne : SKSpriteNode
    var flyHighLabel : SKLabelNode
    
    
    var button:SKLabelNode
    
    
    override init(size: CGSize) {
        background = SKSpriteNode(color: Constants.LIGHT_BLUE, size: Constants.SCREEN_SIZE)
        mountains = SKSpriteNode(imageNamed: "mountain.png")
        balloonOne = SKSpriteNode(imageNamed: "balloon.png")
        flyHighLabel = SKLabelNode(text: "Fly High")
        button = SKLabelNode(text: "Start Game")
        
        
        super.init(size:size)
        background.position = CGPoint(x: Constants.SCREEN_SIZE.width/2 , y: Constants.SCREEN_SIZE.height/2)
        background.zPosition = -1
        
        mountains.size = CGSize(width: Constants.SCREEN_SIZE.width + 50, height: Constants.SCREEN_SIZE.height*0.3)
        mountains.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mountains.zPosition = 1
        mountains.position = CGPoint(x: 0, y: -(Constants.SCREEN_SIZE.height/2-mountains.size.height/2)-35)
        background.addChild(mountains)
        
        balloonOne.position = CGPoint(x: (Constants.SCREEN_SIZE.width/3), y: -(Constants.SCREEN_SIZE.height/2))
        balloonOne.size = CGSize(width: 80, height: 100)
        balloonOne.zPosition = 0
        background.addChild(balloonOne)
        
        flyHighLabel.zPosition = 11
        flyHighLabel.position = CGPoint(x: 0, y: 150)
        flyHighLabel.fontColor = .red
        flyHighLabel.fontName = "Doubledecker DEMO"
        flyHighLabel.fontSize = 50
        flyHighLabel.horizontalAlignmentMode = .center
        
        background.addChild(flyHighLabel)
        
        self.addChild(background)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let riseAction = SKAction.move(to: CGPoint(x: (view.frame.width/3), y: view.frame.height/1.5), duration: 10.0)
        let riseSequence = SKAction.sequence([riseAction,SKAction.removeFromParent()])
        balloonOne.run(riseSequence)
        
        button.name = "Start Game"
        button.fontSize = 30
        button.zPosition = 10
        button.fontName = "Doubledecker DEMO"
        button.fontColor = .red
        button.horizontalAlignmentMode = .center
        button.position = CGPoint(x:0,y:-150)
        background.addChild(button)
        addClouds(5)
    }
    
    private func addClouds(_ number:Int){
        let cloud = SKSpriteNode(imageNamed: "clouds_01.png")
        cloud.size = CGSize(width: Constants.SCREEN_SIZE.width*0.6, height: Constants.SCREEN_SIZE.height*0.15)
        cloud.position = CGPoint(x:(cloud.size.width/2) - 20 ,y:-40)
        cloud.zPosition = 1
        cloud.alpha = 0.7
        background.addChild(cloud)
        
        let cloud2 = SKSpriteNode(imageNamed: "clouds_03.png")
        cloud2.size = CGSize(width: Constants.SCREEN_SIZE.width*0.6, height: Constants.SCREEN_SIZE.height*0.15)
        cloud2.position = CGPoint(x:-(cloud.size.width/2) + 60 ,y:50)
        cloud2.zPosition = 1
        cloud2.alpha = 0.8
        background.addChild(cloud2)
    }
    


    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
           let positionInScene = touch.location(in: self)
           let touchedNode = self.atPoint(positionInScene)

           if let name = touchedNode.name
           {
               if name == "Start Game"
               {
                let gameScene = GameScene(size:Constants.SCREEN_SIZE)
                let transition = SKTransition.flipVertical(withDuration: 1)
                self.view?.presentScene(gameScene, transition: transition)
               }
           }
    }
    
}
