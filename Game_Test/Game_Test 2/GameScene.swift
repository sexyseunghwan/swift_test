//
//  GameScene.swift
//  Game_Test
//
//  Created by 신승환 on 9/21/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
//        let bg = SKSpriteNode()
//        bg.color = .red
//        bg.size = CGSize(width: 100, height: 100)
//        bg.position = CGPoint(x: 0, y: 0)
//        addChild(bg)
        
        //setting()
        Variables.scene = self
        setting()
        
    }
    
    
}
