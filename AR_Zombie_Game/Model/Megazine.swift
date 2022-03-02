//
//  Megazine.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/02.
//

import UIKit

class Megazine: UIButton {
    
    

    
    init(frame: CGRect, amount: Int, curAmount: Int) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        
        makeImage(amount: amount, curAmount: curAmount)
    }
    
   
    
    private func makeImage(amount: Int, curAmount: Int) {
        
        let bulletWidthFrame = self.frame.width/CGFloat(amount)
        
        for i in 0..<curAmount {
            
            let bulletFrame = CGRect(x: bulletWidthFrame * CGFloat(i), y: 0, width: bulletWidthFrame, height: self.frame.height)
            let bullet = BulletImg(frame: bulletFrame,color: UIColor.cyan)
            self.addSubview(bullet)

        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }   

}
