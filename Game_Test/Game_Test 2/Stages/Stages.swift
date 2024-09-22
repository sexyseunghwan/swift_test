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
        
        Variables.scene.physicsWorld.speed = 0.3 // 공의 스피드를 조절할 수 있음.
        
        bg()
        paddleImage()
        ballImage()
        border()
        blocks()
        bottomImage()
        
    }
    
    func bg() {
        
        let bg = SKSpriteNode()
        bg.texture = SKTexture(imageNamed: "qoo")
        bg.size = view.frame.size
        bg.position = CGPoint(x: 0, y: 0)
        bg.zPosition = -1
        Variables.scene.addChild(bg)
    }
    
    func paddleImage() {
        
        Variables.paddle.size = CGSize(width: 200, height: 60)
        Variables.paddle.position = CGPoint(x: 0, y : -view.frame.height / 2 + 30)
        Variables.paddle.texture = SKTexture(imageNamed: "space")
        Variables.paddle.zPosition = 2
        Variables.paddle.name = "paddle"
        Variables.scene.addChild(Variables.paddle)
        
        //물리연산 추가
        Variables.paddle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 45))
        Variables.paddle.physicsBody?.isDynamic = false // 상호작용에 의해서 움직이게 된다.
        Variables.paddle.physicsBody?.allowsRotation = false // 회전하지 않도록 설정
        Variables.paddle.physicsBody?.affectedByGravity = false // 중력적용 불가
        Variables.paddle.physicsBody?.friction = 0 // 마찰을 0으로 하여 물체가 미끄러지도록 한다.
        Variables.paddle.physicsBody?.restitution = 0 // 탄성을 0 으로 하여 충돌시 반발력을 없앤다. 0 이면 튀어오르지 않고 1이면 완전히 튕김
        Variables.paddle.physicsBody?.categoryBitMask = Variables.paddleCategory // paddle 에 고유 비트마스크 할당
        Variables.paddle.physicsBody?.contactTestBitMask = Variables.ballCategory // 충돌감지
    }
    
    
    func ballImage() {
        
        Variables.ball.fillColor = .cyan
        Variables.ball.strokeColor = .red
        Variables.ball.glowWidth = 3 // 빛나는 효과
        Variables.ball.blendMode = .screen // 색깔 섞어주는 효과
        Variables.ball.position = CGPoint(x: Variables.paddle.position.x, y: Variables.paddle.position.y + 30 )
        Variables.ball.name = "ball"
        Variables.scene.addChild(Variables.ball)
        
        //물리연산 추가
        Variables.ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        Variables.ball.physicsBody?.isDynamic = false
        Variables.ball.physicsBody?.affectedByGravity = false // 중력적용 불가
        Variables.ball.physicsBody?.friction = 0
        Variables.ball.physicsBody?.restitution = 1
        Variables.ball.physicsBody?.categoryBitMask = Variables.ballCategory
        //Variables.ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        Variables.ball.physicsBody?.linearDamping = 0 // 공이 시간이 지날수록 속도가 줄어드는데 그걸 막는것
        
        
    }
    
    
    func bottomImage() {
        
        let bottom = SKSpriteNode()
        bottom.size = CGSize(width: view.frame.width, height: 10)
        bottom.position = CGPoint(x: 0, y: -view.frame.height / 2)
        Variables.scene.addChild(bottom)
        bottom.physicsBody = SKPhysicsBody(rectangleOf: bottom.size)
        bottom.physicsBody?.isDynamic = false
        bottom.physicsBody?.affectedByGravity = false
        bottom.physicsBody?.allowsRotation = false
        bottom.physicsBody?.categoryBitMask = Variables.bottomCategory
        bottom.physicsBody?.contactTestBitMask = Variables.ballCategory
    }
    
    // 공이 화면 밖으로 날아가지 못하게 함을 의미
    func border() {
        
        let border = SKPhysicsBody(edgeLoopFrom: Variables.scene.frame)
        border.friction = 0
        border.restitution = 1
        Variables.scene.physicsBody = border
        
    }
    
    
    func blocks() {
        
        let col = 8
        let row = 3
        
        let gab = -25
        let block_w = Int(view.frame.width) / col
        let block_h = Int(block_w / 2) + gab
        
//        let block_w = 70
//        let block_h = 56
        
        print(block_w)
        print(block_h)
        
        let startX = Int(-view.frame.width / 2) + ( block_w + gab )
        let startY = Int(view.frame.height / 2) - block_h + gab
        
        print(startX)
        print(startY)
        
        for i in 0..<col {
            for j in 0..<row {
                let block = SKSpriteNode()
                block.size = CGSize(width: block_w, height: block_h)
                let xValue = (block_w - gab / 2) * i
                let yValue = (block_h - gab) * j
                block.position = CGPoint(x: startX + xValue, y: startY - yValue)
                let num = Int.random(in: 1...7)
                block.texture = SKTexture(imageNamed: "bgn\(num)")
                block.zPosition = 1
                block.name = "bgn\(num)"
                Variables.scene.addChild(block)
                
                // 블록생성할때마다 숫자카운트를 늘려준다.
                Variables.blockNum += 1
                block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: block_w, height: block_h - (gab / 2)))
                block.physicsBody?.isDynamic = false
                block.physicsBody?.affectedByGravity = false
                block.physicsBody?.allowsRotation = false
                block.physicsBody?.categoryBitMask = Variables.blockCategory
                block.physicsBody?.contactTestBitMask = Variables.ballCategory // 충돌감지
                
            }
        }
    }
}
