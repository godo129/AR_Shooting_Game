//
//  GamePointManager.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/01.
//

import Foundation

var storedPointList: [GamePointDetail] = []

func pointListSort() {
    storedPointList.sort {$0.Point > $1.Point}
}
