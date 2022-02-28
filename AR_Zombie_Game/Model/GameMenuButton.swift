//
//  GameMenuButton.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/28.
//

import UIKit

class GameMenuButton: UIButton{
    
    init(color: UIColor, text: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = color
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
