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
    
    var standingSprites: [SKTexture] = []
    var walkingSprites: [SKTexture] = []
    
    private var spriteSheet: BSSpriteSheet
    
    init(character: BSCharacter) {
        self.character = character
        self.uiBar = BSUICharacterBar(character: character)
        self.uiBar.position = CGPoint(x: 0, y: TileHeight)
        self.spriteSheet = BSTextureStore.shared.characterTexture
        self.state = .stand
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
        let animate = SKAction.animate(with: walkingSprites, timePerFrame: 0.2)
        let repeatAnimate = SKAction.repeatForever(animate)
        run(repeatAnimate, withKey: state.rawValue)
    }
    
    func standAnimate() {
//        let textures = [spriteSheet.getTextureFrom(col: 0, row: 1)]
//        let animate = SKAction.animate(with: textures, timePerFrame: 0.2)
//        let repeatAnimate = SKAction.repeatForever(animate)
//        run(repeatAnimate, withKey: state.rawValue)
        texture = standingSprites[0]
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
        
        let blank = [SKTexture(imageNamed: "blankBar_Left"),
                     SKTexture(imageNamed: "blankBar_Mid"),
                     SKTexture(imageNamed: "blankBar_Right")]
        UIGraphicsBeginImageContext(CGSize(width: 36, height: 18))
        let context = UIGraphicsGetCurrentContext()
        
        context?.draw(blank[0].cgImage(), in: CGRect(x: 0, y: 0, width: 9, height: 18))
        context?.draw(blank[1].cgImage(), in: CGRect(x: 9, y: 0, width: 18, height: 18))
        context?.draw(blank[2].cgImage(), in: CGRect(x: 27, y: 0, width: 9, height: 18))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        backgroundBar = SKSpriteNode(texture: SKTexture.init(image: image!), color: .clear, size: size)
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



