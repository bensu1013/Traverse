//
//  BSPlayerGameData.swift
//  Traverse
//
//  Created by Benjamin Su on 2/11/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation


class BSPlayerGameData {
    
    var shared: BSPlayerGameData = BSPlayerGameData()
    
    var coins: Int
    var level: Int?
    var health: Int?
    var gear: Int?
    
    var deck: [BSSkillCard]
    
    private init() {
        coins = 0
        deck = []
    }
    
}
