//
//  ButtonEntity.swift
//  Fly High
//
//  Created by Shresth Pratap Singh on 12/10/19.
//  Copyright © 2019 Shresth. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class Button: SKLabelNode {
    var background:SKSpriteNode
    
    init(title label:String,nodeName:String,backgroundColor:UIColor,size : CGSize,backgroundAlpha : CGFloat = 1) {
       background = SKSpriteNode(color: backgroundColor, size: size)
       background.alpha = backgroundAlpha
        background.zPosition = -1
        super.init()
        self.addChild(background)
        self.text = label
        self.fontName = "Hiragino Sans"
        self.fontSize = 25
        self.verticalAlignmentMode = .center
        self.horizontalAlignmentMode = .center
        self.background.name = nodeName+"background"
        self.name = nodeName
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
