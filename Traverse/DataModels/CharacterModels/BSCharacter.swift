//
//  BSCharacter.swift
//  Traverse
//
//  Created by Benjamin Su on 2/18/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation

class BSCharacter {
    
    var currentHealth: Int
    var maximumHealth: Int
    
    var currentEnergy: Int
    var maximumEnergy: Int
    
    var currentShield: Int
    
    var statusEffects: [String:Int]
    
    init() {
        currentHealth = 10
        maximumHealth = 10
        
        currentEnergy = 5
        maximumEnergy = 5
        
        currentShield = 0
        
        statusEffects = [:]
    }
    
    func takeDamage(_ amount: Int) {
        currentShield -= amount
        if currentShield < 0 {
            currentHealth -= abs(currentShield)
            currentShield = 0
        }
    }
    
    func heal(for amount: Int) {
        currentHealth += amount
        if currentHealth > maximumHealth {
            currentHealth = maximumHealth
        }
    }
    
    func shield(for amount: Int) {
        currentShield += amount
        if currentShield > 999 {
            currentShield = 999
        }
    }
    
}
