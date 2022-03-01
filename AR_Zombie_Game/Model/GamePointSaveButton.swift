//
//  GamePointSaveButton.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/01.
//

import UIKit

class GamePointSaveButton: UIButton {

    init(backColor: UIColor, text: String, textColor: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = backColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
