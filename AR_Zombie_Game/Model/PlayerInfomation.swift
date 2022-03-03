//
//  PlayerInfomation.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/03.
//

import UIKit

class PlayerInfomation {

//    var point: Int
//    var nickName: String
//    var coin: Int
//    var BestPoint: Int
    var curAmountOfBullet: Int
    var AmountOfMagazine: Int
    
    init(AmountOfMagazine: Int, curAmouontOfBullet: Int) {
        
        self.curAmountOfBullet = curAmouontOfBullet
        self.AmountOfMagazine = AmountOfMagazine
        
    }
    
    func usedBullet() {
        self.curAmountOfBullet -= 1
    }
    
}
