//
//  BSParallaxSpriteLayer.swift
//  Traverse
//
//  Created by Benjamin Su on 3/23/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import SpriteKit

class BSParallaxSpriteLayer {
    
    var sprite: SKSpriteNode
    var parallaxFactor: CGFloat
    
    init(sprite: SKSpriteNode, factor: CGFloat) {
        self.sprite = sprite
        self.parallaxFactor = factor
    }
    
    func moveBy(distance: CGFloat, duration: TimeInterval) {
        let move = SKAction.moveBy(x: distance * parallaxFactor, y: 0, duration: duration)
        sprite.run(move)
    }
    
}
