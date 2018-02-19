//
//  BSSpriteSheet.swift
//  Traverse
//
//  Created by Benjamin Su on 2/15/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

struct BSSpriteSheet {
    
    private var texture: SKTexture
    private var cols: CGFloat
    private var rows: CGFloat
    
    /**
     texture is the SKTexture spritesheet
     columns is section count from left to right
     rows is section count from bottom to top
     */
    init(texture: SKTexture, columns: CGFloat, rows: CGFloat) {
        self.texture = texture
        self.cols = columns
        self.rows = rows
    }
    
    func getTextureFrom(col: CGFloat, row: CGFloat) -> SKTexture {
        var rect = CGRect(x: col * texture.size().width/cols,
                          y: row * texture.size().height/rows,
                          width: texture.size().width/cols,
                          height: texture.size().height/rows)
        
        rect = CGRect(x: rect.origin.x/texture.size().width,
                      y: rect.origin.y/texture.size().height,
                      width: rect.size.width/texture.size().width,
                      height: rect.size.height/texture.size().height)
        return SKTexture(rect: rect, in: texture)
    }

}
