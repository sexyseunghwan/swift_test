//
//  Variables.swift
//  Game_Test
//
//  Created by 신승환 on 9/21/24.
//

import Foundation
import SpriteKit

struct Variables {
    
    static var scene = SKScene()
    static var paddle = SKSpriteNode()
    static var ball = SKShapeNode(circleOfRadius: 10)
    
    // 물리법칙
    // 각각의 카테고리 별로 고유값을 지정해준다.
    static let ballCategory : UInt32 = 0x1 << 0     //0000001
    static let paddleCategory : UInt32 = 0x1 << 1   //0000010
    static let bottomCategory : UInt32 = 0x1 << 2   //0000100
    static let blockCategory : UInt32 = 0x1 << 3    //0001000
    
    static var blockNum = 0
    
    static var isplayed = false // 게임이 시작되었는지 체크
}
