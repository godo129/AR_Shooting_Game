//
//  NickNameTextField.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/01.
//

import UIKit

class NickNameTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.placeholder = "NICKNAME"
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
