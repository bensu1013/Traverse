//
//  BSGenericButton.swift
//  Traverse
//
//  Created by Benjamin Su on 2/17/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class BSGenericButton: SKSpriteNode, BSNodeButton {
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
    
    weak var target: AnyObject?
    var selector: Selector?
        
    init(size: CGSize) {
        super.init(texture: nil, color: .clear, size: size)
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
            if (target != nil && target!.responds(to: selector!)) {
                UIApplication.shared.sendAction(selector!, to: target, from: self, for: nil)
            }
        }
    }
    
    func setButtonAction(target: AnyObject, action:Selector) {
        self.target = target
        self.selector = action
    }
    
}

