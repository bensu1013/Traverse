//
//  BSUICardDisplayer.swift
//  Traverse
//
//  Created by Benjamin Su on 2/12/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

protocol BSUICardDisplayerDelegate: AnyObject {
    func cardTapped(_ card: BSSkillCard)
}

class BSUICardDisplayer: SKNode {
    
    var width: CGFloat
    var backgroundNode: SKSpriteNode
    var confirmButton: BSGenericButton
    var visibleCards: [BSUICardSprite]
    
    weak var displayedCard: BSUICardSprite?
    weak var delegate: BSUICardDisplayerDelegate?
    
    private var animationDuration = 0.5
    
    init(sceneSize: CGSize) {
        width = sceneSize.width / 2
        backgroundNode = SKSpriteNode(texture: nil, color: .clear, size: CGSize(width: width, height: 128*1.5))
        visibleCards = []
        
        confirmButton = BSGenericButton(size: CGSize(width: 200, height: 60))
        confirmButton.color = .cyan
        confirmButton.position = CGPoint(x: 200, y: 356)
        confirmButton.isHidden = true
        
        super.init()
        
        addChild(backgroundNode)
        
        confirmButton.setButtonAction(target: self, action: #selector(confirmButtonAction))
        addChild(confirmButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func confirmButtonAction() {
        
        
        if let card = displayedCard,
            let index = visibleCards.index(of: card) {
            // animated card destruction / usage
            
            delegate?.cardTapped(card.skill)
            
            visibleCards.remove(at: index)
            confirmButton.isHidden = true
            card.removeFromParent()
            repositionCards()
            
            insertCard(BSSkillCard(textureType: .hangedman))
        }
        
    }
    
    func insertCard(_ card: BSSkillCard) {
        let newCard = BSUICardSprite(card: card)
        newCard.position = CGPoint(x: -width, y: 0)
        newCard.displayerNode = self
        visibleCards.append(newCard)
        addChild(newCard)
        returnCardAction(newCard, to: visibleCards.count - 1)
    }
    
    func hasActionRunning() -> Bool {
        for card in visibleCards {
            if card.hasActions() { return true }
        }
        return false
    }
    
    func displayCardAction(_ card: BSUICardSprite) {
        displayedCard = card
        let moveAction = SKAction.move(to: CGPoint(x: 0, y: 256), duration: animationDuration)
        let scaleAction = SKAction.scale(to: 1.8, duration: animationDuration)
        card.run(SKAction.group([moveAction, scaleAction]))
    }
    
    func returnCardAction(_ card: BSUICardSprite, to index: Int) {
        let moveAction = SKAction.move(to: CGPoint(x: width / 2 - CGFloat(index * 132), y: 0), duration: animationDuration)
        card.run(moveAction)
        if card.xScale != 1 {
            let scaleAction = SKAction.scale(to: 1, duration: animationDuration)
            card.run(scaleAction)
        }
    }
    
    func repositionCards() {
        for (ind, card) in visibleCards.enumerated() {
            returnCardAction(card, to: ind)
        }
    }
    
    func tapActionBy(card: BSUICardSprite) {
        if hasActionRunning() { return }
        if let displayedCard = displayedCard,
            let index = visibleCards.index(of: displayedCard) {
            returnCardAction(displayedCard, to: index)
            if displayedCard == card {
                self.displayedCard = nil
                confirmButton.isHidden = true
            } else {
                displayCardAction(card)
            }
        } else {
            displayCardAction(card)
            confirmButton.isHidden = false
        }
    }
    
}


class BSUICardSprite: SKSpriteNode, BSNodeButton {
    
    var isEnabled: Bool {
        return isUserInteractionEnabled
    }
    var isSelected: Bool = false
    var nodeParent: SKNode? {
        return parent
    }
    var nodeFrame: CGRect {
        return frame
    }
    
    var skill: BSSkillCard
    weak var displayerNode: BSUICardDisplayer?
    
    init(card: BSSkillCard) {
        self.skill = card
        super.init(texture: SKTexture.init(imageNamed: card.textureType.rawValue), color: .blue, size: CGSize(width: 100, height: 180))
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if hasTouchDown(touches: touches) {
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if hasTouchMove(touches: touches) {
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if hasTouchEnd(touches: touches) {
            displayerNode?.tapActionBy(card: self)
        }
    }
    
    
    
}
