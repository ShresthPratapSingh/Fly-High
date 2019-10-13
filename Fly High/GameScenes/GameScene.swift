//
//  GameScene.swift
//  Fly High
//
//  Created by Shresth Pratap Singh on 12/10/19.
//  Copyright © 2019 Shresth. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var backgroundNode:SKSpriteNode
    var mountains:SKSpriteNode
    var clouds:[SKSpriteNode] = []
    var balloon:SKSpriteNode
    var wordLabel = SKLabelNode(text: "")
    var buttonA = Button(title: "",nodeName:"buttonA", backgroundColor: Constants.blueish, size: CGSize(width:300,height:50), backgroundAlpha: 0.5)
    var buttonB = Button(title: "",nodeName:"buttonB", backgroundColor: Constants.blueish, size: CGSize(width:300,height:50), backgroundAlpha: 0.5)
    var buttonC = Button(title: "",nodeName:"buttonC", backgroundColor: Constants.blueish, size: CGSize(width:300,height:50), backgroundAlpha: 0.5)
    
    var balloonStartPoint :CGPoint!
    var balloonEndPoint : CGPoint!
    var currentQuestionCount = 0
    var shouldSwitchToInitialState = true
    var questionResponses : [String:Any] = [:]
    
    override init(size: CGSize) {
        
        backgroundNode = SKSpriteNode(color: Constants.LIGHT_BLUE, size: Constants.SCREEN_SIZE)
        mountains = SKSpriteNode(imageNamed:"mountain.png")
        
        for imageName in Constants.cloudImageNames(){
                  clouds.append(SKSpriteNode(imageNamed: imageName))
        }
        balloon = SKSpriteNode(imageNamed: "balloon.png")
        
        super.init(size:size)
        
        Networking.delegate = self
        
        backgroundNode.position = CGPoint(x: Constants.SCREEN_SIZE.width/2, y: Constants.SCREEN_SIZE.height/2)
        backgroundNode.zPosition = -1
        
        mountains.size = CGSize(width: Constants.SCREEN_SIZE.width + 50, height: Constants.SCREEN_SIZE.height*0.3)
        mountains.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mountains.zPosition = 1
        mountains.position = CGPoint(x: 0, y: -(Constants.SCREEN_SIZE.height/2-mountains.size.height/2)-35)
        
        balloon.size = CGSize(width: Constants.SCREEN_SIZE.width*0.25, height: Constants.SCREEN_SIZE.height*0.17)
        
        balloonStartPoint = CGPoint(x: -(Constants.SCREEN_SIZE.width/2 - 80),
                                    y: Constants.SCREEN_SIZE.height/2 - balloon.size.height/2)
        balloonEndPoint = CGPoint(x: -(Constants.SCREEN_SIZE.width/2 - 80),
                                  y: -(Constants.SCREEN_SIZE.height/2 + balloon.size.height/2))

        
        balloon.position = balloonStartPoint
        balloon.zPosition = 2
            
        backgroundNode.addChild(balloon)
        backgroundNode.addChild(mountains)
        addChild(backgroundNode)
        
        setupWordLabel()
        setupButtons()
        setupClouds()
        
        switchToInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWordLabel(){
        wordLabel.verticalAlignmentMode = .center
        wordLabel.horizontalAlignmentMode = .center
        wordLabel.color = .red
        wordLabel.fontColor = .white
        wordLabel.fontName = "Doubledecker DEMO"
        wordLabel.fontSize = 35
        
        wordLabel.zPosition = 50
        wordLabel.position = CGPoint(x:0,y:0)
        backgroundNode.addChild(wordLabel)
    }
    
    private func setupButtons(){
        buttonA.position = CGPoint(x: 0, y: -70)
        buttonB.position = CGPoint(x: 0, y: buttonA.position.y - buttonA.background.size.height - 20)
        buttonC.position = CGPoint(x: 0, y: buttonB.position.y - buttonA.background.size.height - 20)
        
        buttonA.zPosition = 50
        buttonB.zPosition = 50
        buttonC.zPosition = 50
        
        backgroundNode.addChild(buttonA)
        backgroundNode.addChild(buttonB)
        backgroundNode.addChild(buttonC)
    }
    
    private func setupClouds(){
        for cloud in clouds{
            cloud.size = CGSize(width: Constants.SCREEN_SIZE.width*0.6, height: Constants.SCREEN_SIZE.height*0.15)
            cloud.zPosition = 0
            cloud.alpha = 0.5
            if cloud == clouds.first{
                cloud.position = CGPoint(x:(cloud.size.width/2 - 20),y:-30)
                cloud.name = "First Cloud"
            }
            else if cloud == clouds.last{
                cloud.position = CGPoint(x: -cloud.size.width/2, y: 150)
                cloud.name = "Second Cloud"
            }
            else{
                cloud.position = CGPoint(x:(cloud.size.width/2 - 20) , y: 300)
                cloud.name = "Third Cloud"
            }
            backgroundNode.addChild(cloud)
            
        }
    }

    
    private func switchToInitialState(){
        if currentQuestionCount <= DataModel.totalQuestions{
            
            if balloon.position != balloonStartPoint{
                balloon.removeAllActions()
//                balloon.run(SKAction.sequence([SKAction.move(to: balloonStartPoint, duration: 3),
//                                               SKAction.wait(forDuration: 1)]))
                balloon.position = balloonStartPoint
            }
                updateWordLabel()
                updateOptions()
                beginFall()
                
                shouldSwitchToInitialState = false
        }
        else{
            DataModel.isGameWon = true
            switchToFinalState()
        }
    }
    
    private func updateWordLabel(){
        wordLabel.text = DataModel.questionData[currentQuestionCount].word
    }
    
    private func updateOptions(){
        buttonA.text = DataModel.questionData[currentQuestionCount].options[0]
        buttonB.text = DataModel.questionData[currentQuestionCount].options[1]
        buttonC.text = DataModel.questionData[currentQuestionCount].options[2]
    }
    
    private func beginFall(){
       balloon.run(SKAction.sequence([SKAction.wait(forDuration: 1) ,
                                                        SKAction.move(to: balloonEndPoint, duration: DataModel.perQuestionDuration)]))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if shouldSwitchToInitialState{
            switchToInitialState()
        }else if balloon.position.y == balloonEndPoint.y{
            switchToFinalState()
        }
    }
    
    let alert = UIAlertController(title: "Please Wait", message: "Submitting Game to server", preferredStyle: .alert)
    let failAlert = UIAlertController(title: "Request Failed", message: "please check your connection", preferredStyle: .alert)
    
    private func switchToFinalState(){
        Networking.submitGame()
        let indicator = UIActivityIndicatorView(frame: alert.view.bounds)
       indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       alert.view.addSubview(indicator)
       indicator.startAnimating()
        
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if (touchedNode.name == "buttonA" || touchedNode.name == "buttonAbackgound"){
            if !(check(optedAnswer: buttonA.text!, for: currentQuestionCount)){
                buttonA.background.color = .red
                buttonA.background.alpha = 1.0
                switchToFinalState()
            }
        }
            else if (touchedNode.name == "buttonB" || touchedNode.name == "buttonAbackgound"){
                if !(check(optedAnswer: buttonB.text!, for: currentQuestionCount)){
                    buttonB.background.color = .red
                    buttonB.background.alpha = 1.0
                    switchToFinalState()
                }
            }
            else if (touchedNode.name == "buttonC" || touchedNode.name == "buttonAbackgound"){
                if !(check(optedAnswer: buttonC.text!, for: currentQuestionCount)){
                   buttonC.background.color = .red
                    buttonC.background.alpha = 1.0
                    switchToFinalState()
               }
            }
        
    }
    
    private func check(optedAnswer response : String,for questionNumber : Int)->Bool{
        DataModel.questionData[questionNumber].isAttempted = true
        DataModel.questionData[questionNumber].response = response
        if response == DataModel.questionData[questionNumber].answer{
            currentQuestionCount += 1
            DataModel.questionData[questionNumber].isCorrect = true
            shouldSwitchToInitialState = true
            return true
        }
        else{
            DataModel.questionData[questionNumber].isCorrect = false
            balloon.removeAllActions()
            balloon.run(SKAction.move(to: balloonEndPoint, duration: 0.5))
            return false
        }
    }

}

extension GameScene:NetworkingProtocol{
    func requestSuccess() {
        alert.dismiss(animated: true, completion: nil)
        let resultScene = GameResultScene(size: Constants.SCREEN_SIZE)
        let transition = SKTransition.flipVertical(withDuration: 1)
        self.view?.presentScene(resultScene, transition: transition)
    }
    
    func requestFailed(with error: Error) {
        
        let tryAgain = UIAlertAction(title: "try again", style:.default) { (UIAlertAction) in
            Networking.submitGame()
            self.failAlert.dismiss(animated:true,completion:nil)
        }
        failAlert.addAction(tryAgain)
        
        self.view?.window?.rootViewController?.present(failAlert, animated: true, completion: nil)
    }
    
    
}
