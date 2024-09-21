//
//  Stages.swift
//  Game_Test
//
//  Created by 신승환 on 9/21/24.
//

import Foundation
import SpriteKit

class Stages {
    
    let view = Variables.scene.view!
    
    init() {
        bg()
        paddle()
    }
    
    func bg() {
        
        let bg = SKSpriteNode()
        bg.texture = SKTexture(imageNamed: "bg1")
        bg.size = view.frame.size
        bg.position = CGPoint(x: 0, y: 0)
        bg.zPosition = -1
        Variables.scene.addChild(bg)
    }
    
    func paddle() {
        
        Variables.paddle.size = CGSize(width: 200, height: 60)
        Variables.paddle.position = CGPoint(x: 0, y : -view.frame.height / 2 + 30)
        Variables.paddle.texture = SKTexture(imageNamed: "bar")
        Variables.paddle.zPosition = 2
        Variables.paddle.name = "paddle"
        Variables.scene.addChild(Variables.paddle)
        
        
    }
    
    
}
