//
//  BulletLabel.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/03.
//

import UIKit

class BulletLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = .center
        self.textColor = .red
        self.font = .systemFont(ofSize: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
