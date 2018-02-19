//
//  BSSkillCard.swift
//  Traverse
//
//  Created by Benjamin Su on 2/12/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

enum BSSkillCardType: String {
    
    case attack, defense
    
}


protocol BSSkillCard: AnyObject {
    
    var type: BSSkillCardType { get set }
    var textureType: BSSkillCardTextureType { get set }
    
    func activate(player: BSCharacter, enemies: [BSCharacter])
    
}

class BSSkillSlash: BSSkillCard {
    var type: BSSkillCardType
    var textureType: BSSkillCardTextureType
    
    init(textureType texture: BSSkillCardTextureType) {
        type = .attack
        textureType = texture
    }
    
    func activate(player: BSCharacter, enemies: [BSCharacter]) {
        player.currentHealth -= 2
    }
    
    
}
