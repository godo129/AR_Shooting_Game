//
//  UIBaord.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/11.
//

import UIKit
import SceneKit

class UIBaord: SCNNode {
    
    var nickName = "Guest"
    
    var positon: SCNVector3!
    var board: SCNBox!
    
    let boardHelper = UIBoardHelper.sharedInstance
    
    
    init(position: SCNVector3) {
        
        super.init()
        
        self.positon = position
        self.board = SCNBox(width: 0.7, height: 1.5, length: 0.01, chamferRadius: 0)
        
        self.board.firstMaterial?.isDoubleSided = true
        self.board.firstMaterial?.diffuse.contents = UIColor.green
        let boardNode = SCNNode(geometry: self.board)
        boardNode.name = "board"
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
        
//        let replayButton = SCNBox(width: board.width/1.5, height: board.height/5, length: board.length*1.5, chamferRadius: 0.2)
//        replayButton.firstMaterial?.diffuse.contents = UIColor.blue
//        let replayButtonNode = SCNNode(geometry: replayButton)
//        replayButtonNode.position = SCNVector3(position.x, position.y, position.z)
//
//        let replayImage = SCNPlane(width: replayButton.width/4, height: replayButton.height/1.5)
//        replayImage.firstMaterial?.diffuse.contents = UIImage(named: "replay")
//        let replayImageNode = SCNNode(geometry: replayImage)
//        replayImageNode.position = SCNVector3(-replayImage.width, replayImage.height/6, replayButton.length)
//        replayButtonNode.addChildNode(replayImageNode)
//
//        self.addChildNode(replayButtonNode)
//
//        let replayText = SCNText(string: "Replay", extrusionDepth: 1)
//        let replayTextNode = SCNNode(geometry: replayText)
//        replayText.firstMaterial?.diffuse.contents = UIColor.red
//        replayTextNode.scale = SCNVector3(replayButton.width/80, replayButton.height/40, 0.001)
//        replayTextNode.position = SCNVector3(-replayImage.width/3, -replayImage.height/4, replayButton.length)
//        replayButtonNode.addChildNode(replayTextNode)
        
//        let replayButton = UIBoardButton(position: position, detailPosition: 1, boardWidth: board.width, boardHeight: board.height, boardLength: board.length, image: UIImage(named: "replay")!, text: "replay")
//        self.addChildNode(replayButton)
////
//        let saveButton = UIBoardButton(position: position, detailPosition: 4, boardWidth: board.width, boardHeight: board.height, boardLength: board.length, image: UIImage(named: "target")!, text: "save")
//        self.addChildNode(saveButton)
//
//        let nickNameBoard = UIBoardButton(position: position, detailPosition: 1, boardWidth: board.width, boardHeight: board.height, boardLength: board.length, image: UIImage(named: "")!, text: nickName)
//        self.addChildNode(nickNameBoard)
//

        
        switch boardHelper.state {
        case .Home:
            
            removeBoardsElements()
            
            let replayButton = UIBoardButton(position: position, detailPosition: 1, boardWidth: board.width, boardHeight: board.height, boardLength: board.length, image: UIImage(named: "replay")!, text: "replay")
            self.addChildNode(replayButton)
            
            let saveButton = UIBoardButton(position: position, detailPosition: 4, boardWidth: board.width, boardHeight: board.height, boardLength: board.length, image: UIImage(named: "target")!, text: "save")
            self.addChildNode(saveButton)
            
        case .Save:
            
            removeBoardsElements()
            
            let nickNameBoard = UIBoardButton(position: position, detailPosition: 1, boardWidth: board.width, boardHeight: board.height, boardLength: board.length, image: UIImage(named: "")!, text: nickName)
            self.addChildNode(nickNameBoard)
            
        }
        
//        initializeBoard()
        
        self.addChildNode(boardNode)
        self.addChildNode(cancelButtonNode)
        
        
    }
    
    func initializeBoard() {
        
        switch boardHelper.state {
        case .Home:
            
            removeBoardsElements()
            
            let replayButton = UIBoardButton(position: position, detailPosition: 1, boardWidth: board.width, boardHeight: board.height, boardLength: board.length, image: UIImage(named: "replay")!, text: "replay")
            self.addChildNode(replayButton)
            
            let saveButton = UIBoardButton(position: position, detailPosition: 4, boardWidth: board.width, boardHeight: board.height, boardLength: board.length, image: UIImage(named: "target")!, text: "save")
            self.addChildNode(saveButton)
            
        case .Save:
            
            removeBoardsElements()
            
            let nickNameBoard = UIBoardButton(position: position, detailPosition: 1, boardWidth: board.width, boardHeight: board.height, boardLength: board.length, image: UIImage(named: "")!, text: nickName)
            self.addChildNode(nickNameBoard)
            
        }
    }
    
    private func removeBoardsElements() {
        for node in self.childNodes {
            guard let name = node.name else {return}
            
            if name != "board" {
                node.removeFromParentNode()
            }
        }
        
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


class UIBoardButton: SCNNode {
    
    init(position: SCNVector3, detailPosition: Float, boardWidth: CGFloat, boardHeight: CGFloat, boardLength: CGFloat, image: UIImage, text: String) {
        
        super.init()
        
        let Button = SCNBox(width: boardWidth/1.5, height: boardHeight/5, length: boardLength*1.5, chamferRadius: 0.2)
        Button.firstMaterial?.diffuse.contents = UIColor.blue
        let ButtonNode = SCNNode(geometry: Button)
        ButtonNode.position = SCNVector3(position.x, position.y/detailPosition, position.z)
        self.addChildNode(ButtonNode)
        ButtonNode.name = text
        
        let buttonImage = SCNPlane(width: Button.width/4, height: Button.height/1.5)
        buttonImage.firstMaterial?.diffuse.contents = image
        let buttonImageNode = SCNNode(geometry: buttonImage)
        buttonImageNode.position = SCNVector3(-buttonImage.width, buttonImage.height/6, Button.length)
        ButtonNode.addChildNode(buttonImageNode)
        
        let buttonText = SCNText(string: text, extrusionDepth: 1)
        let buttonTextNode = SCNNode(geometry: buttonText)
        buttonText.firstMaterial?.diffuse.contents = UIColor.white
        buttonTextNode.scale = SCNVector3(Button.width/80, Button.height/40, 0.001)
        buttonTextNode.position = SCNVector3(-buttonImage.width/3, -buttonImage.height/4, Button.length)
        ButtonNode.addChildNode(buttonTextNode)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
