//
//  Megazine.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/02.
//

import UIKit

class Megazine: UIButton {
    
    var amount = player.AmountOfMagazine
    var curAmount = player.curAmountOfBullet
    
    var bulletList: [BulletImg] = []

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        
        makeImage()
    }
    
    
    func makeImage() {
        
        removeBulletViews()

        let bulletWidthFrame = self.frame.width/CGFloat(self.amount)
        
        for i in 0..<self.curAmount {
            
            let bulletFrame = CGRect(x: bulletWidthFrame * CGFloat(i), y: 0, width: bulletWidthFrame, height: self.frame.height)
            let bullet = BulletImg(frame: bulletFrame,color: UIColor.cyan)
            self.addSubview(bullet)
            bulletList.append(bullet)

        }
        
    }
    
    private func removeBulletViews() {
        for bullet in bulletList {
            bullet.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }   

}
