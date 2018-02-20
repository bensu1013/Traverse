//
//  BSParallaxBackground.swift
//  Traverse
//
//  Created by Benjamin Su on 2/12/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

let backdrop2DArray =    [[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [ 0, 0, 0, 0, 0, 0, 0, 8, 0, 0],
                          [ 0, 0, 0, 8, 0, 0, 0, 9, 0, 0],
                          [ 0, 0, 0, 9, 0, 0, 0, 9, 0, 0],
                          [ 0, 0, 0, 9, 0, 1, 2, 2, 3, 0],
                          [ 0, 0, 0, 9, 0, 4, 7, 7, 5, 0],
                          [ 0, 0, 0, 9, 0, 4, 7, 7, 5, 0],
                          [ 0, 0, 0, 9, 0, 4, 7, 7, 5, 0]]

let background2DArray =  [[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                          [ 0, 1, 3, 0, 0, 0, 0, 0, 0, 0],
                          [ 0, 4, 5, 0, 0, 0, 1, 3, 0, 0],
                          [ 0, 4, 5, 0, 0, 0, 4, 5, 0, 0],
                          [ 0, 4, 5, 0, 0, 0, 4, 5, 0, 0],
                          [ 0, 4, 5, 0, 0, 0, 4, 5, 0, 0],
                          [ 0, 4, 5, 0, 0, 0, 4, 5, 0, 0],
                          [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

// the graphics array needs to be upside down to account for context and sprite flipping afterwards
let foreground2DArray = [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
                         [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
                         [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
                         [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
                         [  0, 60,  0,  0,  0, 53,  0,  0,  0, 61,  0,  0, 51,  0],
                         [  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2],
                         [  7,  7,  7,  6,  7,  7,  7,  7,  6,  7,  7,  7,  7,  6],
                         [  7,  6,  7,  7,  7,  6,  7,  7,  7,  7,  7,  6,  7,  7]]


class BSParallaxBackground: SKNode {
    
    var spriteLayers: [BSParallaxSpriteLayer]
    
    init(scene: BSGameScene) {

        spriteLayers = []
        
        super.init()
        
        let moon = SKSpriteNode(texture: SKTexture(imageNamed: "BG"), size: CGSize(width: 2000, height: 1143))
        moon.zPosition = -1000
        addChild(moon)
        let moonLayer = BSParallaxSpriteLayer(sprite: moon, factor: 0.0)
        spriteLayers.append(moonLayer)
        
        let backdrop = BSGroundTextures.shared.createSingleSpriteObject(from: backdrop2DArray)
        backdrop.zPosition = -500
        backdrop.position.x = (backdrop.size.width - scene.size.width) / 2
        addChild(backdrop)
        let backdropLayer = BSParallaxSpriteLayer(sprite: backdrop, factor: 0.18)
        spriteLayers.append(backdropLayer)
        
        let background = BSGroundTextures.shared.createSingleSpriteObject(from: background2DArray)
        background.zPosition = -400
        background.position.x = (background.size.width - scene.size.width) / 2
        addChild(background)
        let backgroundLayer = BSParallaxSpriteLayer(sprite: background, factor: 0.45)
        spriteLayers.append(backgroundLayer)
        
        let ground = BSGroundTextures.shared.createSingleSpriteObject(from: foreground2DArray)
        ground.zPosition = -300
        ground.position.x = (ground.size.width - scene.size.width) / 2
        addChild(ground)
        let groundLayer = BSParallaxSpriteLayer(sprite: ground, factor: 1.0)
        spriteLayers.append(groundLayer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveLayersBy(distance: CGFloat, duration: TimeInterval) {
        for layer in spriteLayers {
                layer.moveBy(distance: distance, duration: duration)
        }
    }
    
}

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




