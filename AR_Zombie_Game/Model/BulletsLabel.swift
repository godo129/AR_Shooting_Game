//
//  BulletsLabel.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/22.
//

import UIKit

class BulletsLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        customLabel()
    }
    
    private func customLabel() {
        textColor = .orange
        font = .systemFont(ofSize: 25, weight: .bold)
    }

}
