//
//  BulletImg.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/02.
//

import UIKit

class BulletImg: UIButton {
    
    init(frame: CGRect,color: UIColor) {
        super.init(frame: frame)
        self.backgroundColor = color
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
