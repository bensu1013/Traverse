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







