//
//  GamePointLabel.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/28.
//

import UIKit

class GamePointLabel: UILabel {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.font = .systemFont(ofSize: 30, weight: .bold)
        self.textColor = .systemMint
        self.textAlignment = .center
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
