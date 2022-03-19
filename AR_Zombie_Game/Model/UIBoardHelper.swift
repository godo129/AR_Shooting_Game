//
//  UIBoardHelper.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/19.
//

import UIKit

class UIBoardHelper {
    
    static let sharedInstance = UIBoardHelper()
    
    var state = UIBoardStateType.Home
    
    enum UIBoardStateType {
        case Home
        case Save
    }

}
