//
//  BSUICharacterBar.swift
//  Traverse
//
//  Created by Benjamin Su on 3/23/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import SpriteKit

class BSUICharacterBar: SKNode {
    
    var healthBar: BSUIAdjustingTextBar
    var energyBar: BSUIAdjustingTextBar
    
    init(character: BSCharacter) {
        healthBar = BSUIAdjustingTextBar(color: .red, size: CGSize(width: TileWidth, height: TileHeight / 3))
        healthBar.position = CGPoint(x: 0, y: TileHeight/3)
        energyBar = BSUIAdjustingTextBar(color: .red, size: CGSize(width: TileWidth, height: TileHeight / 3))
        energyBar.position = CGPoint(x: 0, y: -TileHeight/3)
        
        super.init()
        addChild(energyBar)
        addChild(healthBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWith(character: BSCharacter) {
        healthBar.textNode.text = "\(character.currentHealth) / \(character.maximumHealth)"
        energyBar.textNode.text = "\(character.currentEnergy) / \(character.maximumEnergy)"
        healthBar.adjustingBar.size.width = healthBar.backgroundBar.size.width * CGFloat(character.currentHealth) / CGFloat(character.maximumHealth)
    }
    
}
