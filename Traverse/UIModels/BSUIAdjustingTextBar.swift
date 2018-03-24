//
//  BSUIAdjustingTextBar.swift
//  Traverse
//
//  Created by Benjamin Su on 3/23/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import SpriteKit

class BSUIAdjustingTextBar: SKNode {
    
    var backgroundBar: SKSpriteNode
    var adjustingBar: SKSpriteNode
    var textNode: SKLabelNode
    
    
    init(color: UIColor, size: CGSize) {
        
//        let blank = [SKTexture(imageNamed: "blankBar_Left"),
//                     SKTexture(imageNamed: "blankBar_Mid"),
//                     SKTexture(imageNamed: "blankBar_Right")]
//        UIGraphicsBeginImageContext(CGSize(width: 36, height: 18))
//        let context = UIGraphicsGetCurrentContext()
//        
//        context?.draw(blank[0].cgImage(), in: CGRect(x: 0, y: 0, width: 9, height: 18))
//        context?.draw(blank[1].cgImage(), in: CGRect(x: 9, y: 0, width: 18, height: 18))
//        context?.draw(blank[2].cgImage(), in: CGRect(x: 27, y: 0, width: 9, height: 18))
//        
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
        let barTexture = SKTexture(imageNamed: "blankBar_Mid")
        backgroundBar = SKSpriteNode(texture: barTexture, color: .clear, size: size)
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
