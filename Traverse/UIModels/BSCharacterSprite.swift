//
//  BSCharacterSprite.swift
//  Traverse
//
//  Created by Benjamin Su on 2/12/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

enum CharacterSpriteState: String {
    case stand, walk, jump, fall
}

class BSCharacterSprite: SKSpriteNode {
    
    var health: Int
    var energy: Int
    var uiBar: BSUICharacterBar
    var state: CharacterSpriteState
    
    var spriteSheet: BSSpriteSheet
    
    init() {
        health = 10
        energy = 5
        uiBar = BSUICharacterBar()
        uiBar.position = CGPoint(x: 0, y: 200)
        spriteSheet = BSTextureStore.shared.characterTexture
        state = .stand
        super.init(texture: spriteSheet.getTextureFrom(col: 0, row: 1), color: .clear, size: CGSize(width: 128, height: 128))
        isUserInteractionEnabled = true;
        addChild(uiBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(dt: TimeInterval) {
        animate()
    }
    
    func animate() {
        if let action = action(forKey: state.rawValue) {
            
        } else {
            removeAllActions()
            switch state {
            case .stand:
                standAnimate()
            case .walk:
                walkAnimate()
            default:
                standAnimate()
            }
        }
    }
    
    func walkAnimate() {
        let textures = [spriteSheet.getTextureFrom(col: 14, row: 1),
                        spriteSheet.getTextureFrom(col: 15, row: 1),
                        spriteSheet.getTextureFrom(col: 16, row: 1),
                        spriteSheet.getTextureFrom(col: 17, row: 1)]
        let animate = SKAction.animate(with: textures, timePerFrame: 0.2)
        let repeatAnimate = SKAction.repeatForever(animate)
        run(repeatAnimate, withKey: state.rawValue)
    }
    
    func standAnimate() {
//        let textures = [spriteSheet.getTextureFrom(col: 0, row: 1)]
//        let animate = SKAction.animate(with: textures, timePerFrame: 0.2)
//        let repeatAnimate = SKAction.repeatForever(animate)
//        run(repeatAnimate, withKey: state.rawValue)
        texture = spriteSheet.getTextureFrom(col: 0, row: 1)
    }
    
}

class BSUICharacterBar: SKNode {
    
    var healthBar: BSUIAdjustingTextBar
    var energyBar: BSUIAdjustingTextBar
    
    override init() {
        healthBar = BSUIAdjustingTextBar(color: .red, size: CGSize(width: 160, height: 40))
        healthBar.position = CGPoint(x: 0, y: 45)
        energyBar = BSUIAdjustingTextBar(color: .red, size: CGSize(width: 160, height: 40))
        energyBar.position = CGPoint(x: 0, y: -45)
        super.init()
        addChild(energyBar)
        addChild(healthBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BSUIAdjustingTextBar: SKNode {
    
    var backgroundBar: SKSpriteNode
    var adjustingBar: SKSpriteNode
    var textNode: SKLabelNode
    
    
    init(color: UIColor, size: CGSize) {
        
        backgroundBar = SKSpriteNode(texture: nil, color: .black, size: size)
        
        adjustingBar = SKSpriteNode(texture: nil, color: color, size: size)
        
        textNode = SKLabelNode(text: "10/10")
        
        super.init()
        
        addChild(backgroundBar)
        addChild(adjustingBar)
        addChild(textNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



