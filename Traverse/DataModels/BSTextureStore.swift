//
//  BSTextureStore.swift
//  Traverse
//
//  Created by Benjamin Su on 2/16/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class BSTextureStore {
    static let shared = BSTextureStore()
    
    let characterTexture = BSSpriteSheet(texture: SKTexture.init(imageNamed: "characters_texture"), columns: 23, rows: 4)
    let groundTexture = BSSpriteSheet(texture: SKTexture.init(imageNamed: "ground_texture"), columns: 17, rows: 8)
    
    private init() {}
    
}
