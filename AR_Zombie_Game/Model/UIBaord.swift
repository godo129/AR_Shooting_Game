//
//  UIBaord.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/11.
//

import UIKit
import SceneKit

class UIBaord: SCNNode {
    
    
    init(position: SCNVector3) {
        
        super.init()
        
        let board = SCNBox(width: 0.5, height: 0.3, length: 0.01, chamferRadius: 0)
//        let board = SCNPlane(width: 0.5, height: 0.3)
        board.firstMaterial?.isDoubleSided = true
        board.firstMaterial?.diffuse.contents = UIColor.green
        let boardNode = SCNNode(geometry: board)
        boardNode.position = position
        
        guard let cancelButtonScene = SCNScene(named: "art.scnassets/cancelButton.scn") else {return}
        guard let cancelButtonNode = cancelButtonScene.rootNode.childNode(withName: "cancelButton", recursively: true) else {return}
        cancelButtonNode.name = "cancelButton"
        
//        let cancelButton = SCNPlane(width: 0.1, height: 0.1)
//        let cancelButton = SCNSphere(radius: 0.05)
//        let cancelButton = SCNCylinder(radius: 0.1, height: 0.1)
//        cancelButton.firstMaterial?.diffuse.contents = UIColor.red
//        let cancelButtonNode = SCNNode(geometry: cancelButton)
        cancelButtonNode.position = SCNVector3(position.x+(board.width/2).toFloat()-cancelButtonNode.scale.y,
                                               position.y+(board.height/2).toFloat()-cancelButtonNode.scale.y,
                                               position.z)

        self.addChildNode(cancelButtonNode)
        self.addChildNode(boardNode)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension CGFloat {
    func toFloat() -> Float {
        return Float(self)
    }
}
