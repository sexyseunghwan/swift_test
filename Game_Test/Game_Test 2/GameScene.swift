//
//  GameScene.swift
//  Game_Test
//
//  Created by 신승환 on 9/21/24.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let motion = CMMotionManager()
    
    override func didMove(to view: SKView) {
        
        //setting()
        Variables.scene = self
        self.physicsWorld.contactDelegate = self
        setting()
        
    }
    
    
}
