//
//  GameScene.swift
//  Traverse
//
//  Created by Benjamin Su on 2/11/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import SpriteKit

class BSGameScene: SKScene, BSUICardDisplayerDelegate {
    
    var parallax: BSParallaxBackground?
    var cardDisplayer: BSUICardDisplayer?
    
    var playerSprite: BSCharacterSprite?
    var enemySprites: [BSCharacterSprite] = []
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor.init(red: 0.14, green: 0.15, blue: 0.3, alpha: 0.8)
        
        let bgSprite = BSParallaxBackground(scene: self)
        bgSprite.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(bgSprite)
        parallax = bgSprite
        
        
        let cardDisplayer = BSUICardDisplayer(sceneSize: self.size)
        cardDisplayer.position = CGPoint(x: self.size.width / 2, y: 120)
        cardDisplayer.zPosition = 1000
        cardDisplayer.delegate = self
        addChild(cardDisplayer)
        self.cardDisplayer = cardDisplayer
        
        let node = BSCharacterSprite(character: BSCharacter())
        node.position = CGPoint(x: self.size.width / 5, y: (self.size.height - CGFloat(TileHeight)) / 2 )
        node.standingSprites = [BSTextureStore.shared.characterTexture.getTextureFrom(col: 0, row: 1)]
        
        node.walkingSprites = [BSTextureStore.shared.characterTexture.getTextureFrom(col: 14, row: 1),
                               BSTextureStore.shared.characterTexture.getTextureFrom(col: 15, row: 1),
                               BSTextureStore.shared.characterTexture.getTextureFrom(col: 16, row: 1),
                               BSTextureStore.shared.characterTexture.getTextureFrom(col: 17, row: 1)]
        addChild(node)
        playerSprite = node
                
        let standSprite = [BSTextureStore.shared.characterTexture.getTextureFrom(col: 0, row: 0)]
        let walkSprite = [BSTextureStore.shared.characterTexture.getTextureFrom(col: 0, row: 0),
                          BSTextureStore.shared.characterTexture.getTextureFrom(col: 1, row: 0),
                          BSTextureStore.shared.characterTexture.getTextureFrom(col: 2, row: 0),
                          BSTextureStore.shared.characterTexture.getTextureFrom(col: 3, row: 0)]
        
        for c in 0...2 {
            let enemyNode = BSCharacterSprite(character: BSCharacter())
            enemyNode.xScale = -1
            enemyNode.position = CGPoint(x: self.size.width / 8 * CGFloat(4 + c), y: (self.size.height - CGFloat(TileHeight)) / 2 )
            enemyNode.standingSprites = standSprite
            enemyNode.walkingSprites = walkSprite
            addChild(enemyNode)
            enemySprites.append(enemyNode)
        }
        
        
        cardDisplayer.insertCard(BSSkillSlash(textureType: .chariot))
        cardDisplayer.insertCard(BSSkillSlash(textureType: .devil))
        cardDisplayer.insertCard(BSSkillSlash(textureType: .empress))
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveToNextBattle()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        playerSprite?.update(dt: currentTime)
        for enemySprite in enemySprites {
            enemySprite.update(dt: currentTime)
        }
    }
    
    func moveToNextBattle() {
        parallax?.moveLayersBy(distance: -100, duration: 4)
        playerSprite?.state = .walk
        for enemy in enemySprites {
            enemy.state = .walk
        }
        let wait = SKAction.wait(forDuration: 4)
        run(wait) {
            self.playerSprite?.state = .stand
            for enemy in self.enemySprites {
                enemy.state = .stand
            }
        }
    }
    
    
    func cardTapped(_ card: BSSkillCard) {
        card.activate(player: playerSprite!.character, enemies: enemySprites.map({$0.character}))
    }
    
}
