//
//  test.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/28.
//

import UIKit

class GameMenuView: UIView {

    private let restartButton = GameMenuButton(color: UIColor.systemBlue, text: "Restart")
    private let restorePointButton = GameMenuButton(color: UIColor.systemRed, text: "Restore Point")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(restartButton)
        self.addSubview(restorePointButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        restartButton.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        restartButton.center = self.center
        
        restorePointButton.frame = CGRect(x: self.restartButton.frame.origin.x , y: self.restartButton.frame.origin.y+200, width: 200, height: 100)
    }
}
