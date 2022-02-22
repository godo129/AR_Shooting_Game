//
//  ReloadButton.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/22.
//

import UIKit

class ReloadButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        customButton()
    }
    
    private func customButton() {
        
        backgroundColor = .white
        setTitleColor(.orange, for: .normal)
        layer.cornerRadius = 10
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
        setTitle("Reload", for: .normal)
    }

}
