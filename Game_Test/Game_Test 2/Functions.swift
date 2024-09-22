//
//  Functions.swift
//  Game_Test
//
//  Created by 신승환 on 9/21/24.
//

import Foundation
import SpriteKit

extension GameScene {
    
    
    func setting() {
        let stage = Stages()
        //tilting()
    }
    
    // 처음 터치하였을때
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self) // 터치한곳에 대한 정보가 들어온다.
            
            if Variables.isplayed {
                Variables.paddle.run(SKAction.moveTo(x: location.x, duration: 0.2)) // duration 은 움직이는 속도
            } else {
                Variables.paddle.run(SKAction.moveTo(x: location.x, duration: 0.2)) // duration 은 움직이는 속도
                Variables.ball.run(SKAction.moveTo(x: location.x, duration: 0.2)) // duration 은 움직이는 속도
            }
            
        }
    }
    
    // 터치 후 움직였을 때
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self) // 터치한곳에 대한 정보가 들어온다.
            
            if Variables.isplayed {
                Variables.paddle.run(SKAction.moveTo(x: location.x, duration: 0.2)) // duration 은 움직이는 속도
            } else {
                Variables.paddle.run(SKAction.moveTo(x: location.x, duration: 0.2)) // duration 은 움직이는 속도
                Variables.ball.run(SKAction.moveTo(x: location.x, duration: 0.2)) // duration 은 움직이는 속도
            }

        }
    }
    
    // 터치가 종료되었을 때
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            
            // 터치가 끝난곳의 이름이 패들이라면
            if node.name == "paddle" {
                if !Variables.isplayed {
                    Variables.isplayed = true
                    Variables.ball.physicsBody?.isDynamic = true
                    Variables.ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
                }
            }
            
        }
    }
    
    // 특정 피직스 바디가 어떤 피직스 바디에 닿았는지 체크해주는 함수
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 공이 바닥에 닿았을 경우
        if firstBody.categoryBitMask == Variables.ballCategory && secondBody.categoryBitMask == Variables.bottomCategory {
            // 게임 오버
            print("게임 오버")
            firstBody.node?.removeFromParent()
            Variables.isplayed = false
        }
        
        // 공이 블럭에 닿았을 경우에
        if firstBody.categoryBitMask == Variables.ballCategory && secondBody.categoryBitMask == Variables.blockCategory {
            // 벽돌을 제거 해준다.
            print("블럭 제거")
            
            // 효과음 처리
            let num : String = String(secondBody.node!.name!.last!)
            let soundName = "sound\(num)"
            firstBody.node!.run(SKAction.playSoundFileNamed(soundName, waitForCompletion: false))
            
            // 블럭제거 효과
            emitter(blockName: secondBody.node!.name!, point: secondBody.node!.position)
            
            secondBody.node?.removeFromParent()// 블럭을 제거한다.
            
            //블럭제거 카운트
            Variables.blockNum -= 1
            
            
            if Variables.blockNum == 0 {
                print("게임 클리어")
            }
            
        }
        
        // 공이 패들에 닿았을 경우에
        if firstBody.categoryBitMask == Variables.ballCategory && secondBody.categoryBitMask == Variables.paddleCategory {
            firstBody.node?.run(SKAction.playSoundFileNamed("paddle", waitForCompletion: false))
        }
        
    }
    
    // 블럭제거 효과 주기
    func emitter(blockName: String, point: CGPoint) {
        
        let emit = SKEmitterNode(fileNamed: "Snowing.sks")
        emit?.particleTexture = SKTexture(imageNamed: blockName)
        emit?.position = point
        emit?.zPosition = 2
        Variables.scene.addChild(emit!)
        
        // 일정시간이 지나면 효과가 사라져야 하므로
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            emit?.removeFromParent()
            emit?.removeAllActions()
        }
            
        
    }
    
    // 핸드폰 기울기로 패드 움직이기 -> 쓰지는 않을거임.
    func tilting() {
        motion.accelerometerUpdateInterval = 0.1 // 0.1 초 단위로 값을 갱신
        motion.startDeviceMotionUpdates(to: .main) {(data, error) in
            let value = data!.userAcceleration.y * 1000
            print("data: \(value)")
            Variables.paddle.run(SKAction.moveTo(x: CGFloat(value), duration: 0.2))
        }
    }
}
