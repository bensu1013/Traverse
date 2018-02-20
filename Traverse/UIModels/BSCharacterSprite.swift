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
    
    var character: BSCharacter
    var uiBar: BSUICharacterBar
    var state: CharacterSpriteState
    
    var spriteSheet: BSSpriteSheet
    
    init() {
        character = BSCharacter()
        uiBar = BSUICharacterBar(character: character)
        uiBar.position = CGPoint(x: 0, y: TileHeight)
        spriteSheet = BSTextureStore.shared.characterTexture
        state = .stand
        super.init(texture: spriteSheet.getTextureFrom(col: 0, row: 1), color: .clear, size: CGSize(width: TileWidth, height: TileHeight))
        isUserInteractionEnabled = true;
        addChild(uiBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(dt: TimeInterval) {
        updateUI()
        animate()
    }
    
    func updateUI() {
        uiBar.updateWith(character: character)
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

class BSUIAdjustingTextBar: SKNode {
    
    var backgroundBar: SKSpriteNode
    var adjustingBar: SKSpriteNode
    var textNode: SKLabelNode
    
    
    init(color: UIColor, size: CGSize) {
        
        backgroundBar = SKSpriteNode(texture: nil, color: .black, size: size)
        adjustingBar = SKSpriteNode(texture: nil, color: color, size: size)
        
        textNode = SKLabelNode(text: "")
        
        super.init()
        
        addChild(backgroundBar)
        addChild(adjustingBar)
        addChild(textNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



