//
//  BSNodeButton.swift
//  Traverse
//
//  Created by Benjamin Su on 2/13/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

protocol BSNodeButton : AnyObject {
    
    var isEnabled: Bool { get }
    var isSelected: Bool { get set }
    var nodeParent: SKNode? { get }
    var nodeFrame: CGRect { get }
    
    func hasTouchDown(touches: Set<UITouch>) -> Bool
    func hasTouchMove(touches: Set<UITouch>) -> Bool
    func hasTouchEnd(touches: Set<UITouch>) -> Bool
}

extension BSNodeButton {
    
    func hasTouchDown(touches: Set<UITouch>) -> Bool {
        if (!isEnabled) {
            return false
        }
        isSelected = true
        return true
    }
    
    func hasTouchMove(touches: Set<UITouch>) -> Bool {
        if (!isEnabled) {
            return false
        }
        let touch: AnyObject! = touches.first
        let touchLocation = touch.location(in: nodeParent!)
        if (nodeFrame.contains(touchLocation)) {
            isSelected = true
            return true
        } else {
            isSelected = false
            return false
        }
    }
    
    func hasTouchEnd(touches: Set<UITouch>) -> Bool {
        if (!isEnabled) {
            return false
        }
        isSelected = false
        let touch: AnyObject! = touches.first
        let touchLocation = touch.location(in: nodeParent!)
        
        if (nodeFrame.contains(touchLocation) ) {
            return true
        }
        return false
    }
    
}
