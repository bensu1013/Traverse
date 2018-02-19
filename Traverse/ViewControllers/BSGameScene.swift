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
    var playerSprite: BSCharacterSprite?
    var cardDisplayer: BSUICardDisplayer?
    
    var isDisplayingCard: Bool = false
    
    override func didMove(to view: SKView) {
        
        let bgSprite = BSParallaxBackground(info: [])
        bgSprite.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(bgSprite)
        parallax = bgSprite
        
        let node = BSCharacterSprite()
        node.position = CGPoint(x: self.size.width / 5, y: self.size.height / 2)
        addChild(node)
        playerSprite = node
        
        let cardDisplayer = BSUICardDisplayer(sceneSize: self.size)
        cardDisplayer.position = CGPoint(x: self.size.width / 2, y: 120)
        cardDisplayer.zPosition = 1000
        cardDisplayer.delegate = self
        addChild(cardDisplayer)
        self.cardDisplayer = cardDisplayer
        
        backgroundColor = UIColor.init(red: 0.14, green: 0.15, blue: 0.3, alpha: 0.8)
        
        
        cardDisplayer.insertCard(BSSkillCard(textureType: .chariot))
        cardDisplayer.insertCard(BSSkillCard(textureType: .devil))
        cardDisplayer.insertCard(BSSkillCard(textureType: .empress))
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveToNextBattle()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        playerSprite?.update(dt: currentTime)
    }
    
    func moveToNextBattle() {
        parallax?.moveLayersBy(distance: -100, duration: 4)
        playerSprite?.state = .walk
        let wait = SKAction.wait(forDuration: 4)
        run(wait) {
            self.playerSprite?.state = .stand
        }
    }
    
    
    func cardTappedAt(index: Int) {
        if !isDisplayingCard {
            let action = SKAction.move(to: convert(CGPoint(x:size.width / 2, y:size.height / 2), to: cardDisplayer!), duration: 1)
            cardDisplayer?.visibleCards[index].run(action, completion: { 
                
            })
            isDisplayingCard = true
        }
        
    }
    
}
