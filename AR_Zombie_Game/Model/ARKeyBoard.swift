//
//  ARKeyBoard.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/14.
//

import UIKit
import SceneKit

class ARKeyBoard: SCNNode {
    
    var keyboard = SCNBox(width: 0.8, height: 0.2, length: 0.1, chamferRadius: 0)
    
    var pressedShift = false
    
    let keyboardListNotPressedShift = [["₩","1","2","3","4","5","6","7","8","9","0","-","=","<-"],
                                ["q","w","e","r","t","y","u","i","o","p","[","]","\\"],
                                ["a","s","d","f","g","h","j","k","l",";","'","ENTER"],
                                ["SHIFT","z","x","c","v","b","n","m",",",".","/","SHIFT"],
                                ["SPACE"]]
    
    let keyboardListPressedShift = [["~","!","@","#","$","%","^","&","*","(",")","_","+","<-"],
                                    ["Q","W","E","R","T","Y","U","I","O","P","{","}","|"],
                                    ["A","S","D","F","G","H","J","K","L",":","\"","ENTER"],
                                    ["SHIFT","Z","X","C","V","B","N","M","<",">","?","SHIFT"],
                                    ["SPACE"]]
    
    init(position: SCNVector3) {
        super.init()
        
        self.position = position
        self.name = "Keyboard"
        
        
        // 키보드 보드
        let keyboard = SCNBox(width: 0.8, height: 0.2, length: 0.1, chamferRadius: 0)
        let keyboardMaterial = SCNMaterial()
        var keyboardMaterials = [SCNMaterial]()
        // 색 변경 
        for i in 0..<6 {
            let material = keyboardMaterial
            if i == 0 {
                material.diffuse.contents = UIColor.white
            }
            else {
                material.diffuse.contents = UIColor.gray
            }
            keyboardMaterials.append(material)
        }
        keyboard.materials = keyboardMaterials
        let keyboardNode = SCNNode(geometry: keyboard)
        keyboardNode.position = position
        self.addChildNode(keyboardNode)
        
        
        // 키 버튼 ... 일반 버튼, shift, enter, space 는 다른 크기로 ... 대신 height 는 다 동일 , width만 다름
        
        addKey(position: position, keyboard: keyboard, keyboardNode: keyboardNode)
        
    }
    
    func addKey(position: SCNVector3, keyboard: SCNBox, keyboardNode: SCNNode) {
        
        var keyboardKeyList: [[String]] = [[]]
        
        if pressedShift {
            keyboardKeyList = keyboardListPressedShift
        } else {
            keyboardKeyList = keyboardListNotPressedShift
        }
    
        var y = position.y - Float(keyboard.height)/2
        
        for keyboarList in keyboardKeyList {
            
            y += Float(keyboard.height/7)
            var x = position.x - Float(keyboard.width)/2
            
            for keyCap in keyboarList  {
                let key = KeyButton(keyboard: keyboard, key: keyCap)
                key.position = SCNVector3(x, y, position.z)
                keyboardNode.addChildNode(key)
                x += Float(keyboard.width/15)
            }
      
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class KeyButton: SCNNode {
    
    init(keyboard: SCNBox, key: String) {
        super.init()
        
        self.name = key
        
        let keyButton = SCNBox(width: keyboard.width/15, height: keyboard.height/7, length: keyboard.length*1.5, chamferRadius: 0)
        keyButton.firstMaterial?.diffuse.contents = UIColor.gray
        self.geometry = keyButton
        self.position = position
        let keyNode = SCNNode(geometry: keyButton)
        self.addChildNode(keyNode)
        
        let text = SCNText(string: key, extrusionDepth: 1)
        text.firstMaterial?.diffuse.contents = UIColor.white
        let textNode = SCNNode(geometry: text)
        keyNode.addChildNode(textNode)
        textNode.scale = SCNVector3(keyButton.width/15, keyButton.width/6, 0.0001)
        textNode.position = SCNVector3(0, 0, keyButton.length)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
