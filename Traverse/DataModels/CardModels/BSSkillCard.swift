//
//  BSSkillCard.swift
//  Traverse
//
//  Created by Benjamin Su on 2/12/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation

enum BSSkillCardType: String {
    
    case attack, defense
    
}


class BSSkillCard {
    
    var type: BSSkillCardType
    var textureType: BSSkillCardTextureType
    
    
    init(textureType texture: BSSkillCardTextureType) {
        type = .attack
        textureType = texture
        
    }
    
    
    
}
