//
//  Bullet.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/23.
//

import UIKit
import SceneKit

struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let count  = CollisionCategory(rawValue: 1 << 0) //moves 0 bits to left for 0000001
    static let bullet = CollisionCategory(rawValue: 1 << 1) //moves 1 bits to left for 00000001 then you have 00000010
    static let zombie = CollisionCategory(rawValue: 1 << 2) //moves 1 bits to left for 00000001 then you have 00000100
}

class Bullet: SCNNode {
    override init () {
        super.init()
        let sphere = SCNSphere(radius: 0.025)
        self.geometry = sphere
        let shape = SCNPhysicsShape(geometry: sphere, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.bullet.rawValue // 충돌 카테고리 부여
        self.physicsBody?.contactTestBitMask = CollisionCategory.count.rawValue // 충돌을 몇번 할 것인지
        self.physicsBody?.collisionBitMask = CollisionCategory.zombie.rawValue // 충돌할 카테고리
        
        self.geometry?.materials.first?.diffuse.contents = UIColor.purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
