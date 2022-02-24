//
//  Zombie.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/24.
//

import UIKit
import SceneKit

class Zombie: SCNNode {
    
    override init() {
        super.init()
        let sphere = SCNSphere(radius: 0.25)
        self.geometry = sphere
        let shape = SCNPhysicsShape(geometry: sphere, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.categoryBitMask = CollisionCategory.zombie.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.count.rawValue
        self.physicsBody?.collisionBitMask = CollisionCategory.bullet.rawValue
        
        guard let zombieScene = SCNScene(named: "art.scnassets/zombie.dae") else {return}
        guard let zombieNode = zombieScene.rootNode.childNode(withName: "Zombie", recursively: true) else {return}

        
        self.addChildNode(zombieNode)

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
