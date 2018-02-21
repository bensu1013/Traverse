//
//  BSGroundTexture.swift
//  Traverse
//
//  Created by Benjamin Su on 2/16/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

/// Tuple of two CGFloat
typealias TF = (col:CGFloat, row:CGFloat)

enum BSGroundTextureType: Int {
    case orangeTopLeftCorner = 1
    case orangeTopMiddle
    case orangeTopRightCorner
    case orangeLeftRidge
    case orangeRightRidge
    case orangeDustCenter
    case emptyDustCenter
    
    case orangeTopColumn
    case orangeMidColumn
    
    case grassOne = 50
    case grassTwo
    case grassThree
    case grassFour
    
    case rockLarge = 60
    case rockSmall
}

class BSGroundTextures {
    static let shared = BSGroundTextures()
    private let orangeTopLeftCorner:    TF = (10,7)
    private let orangeTopMiddle:        TF = (11,7)
    private let orangeTopRightCorner:   TF = (12,7)
    private let orangeLeftRidge:        TF = (10,6)
    private let orangeRightRidge:       TF = (12,6)
    private let orangeDustCenter:       TF = (7,6)
    private let emptyDustCenter:        TF = (11,6)
    
    private let orangeTopColumn:        TF = (13,7)
    private let orangeMidColumn:        TF = (13,6)
    
    
    private let grassOne:   TF = (14,1)
    private let grassTwo:   TF = (15,1)
    private let grassThree: TF = (14,2)
    private let grassFour:  TF = (15,2)
    
    private let rockLarge:  TF = (16,1)
    private let rockSmall:  TF = (16,2)
    
    private init() {}
    
    private func getTextureLocation(with type: BSGroundTextureType) -> TF? {
        var textureLocation: TF?
        switch type {
        case .orangeTopLeftCorner:
            textureLocation = orangeTopLeftCorner
        case .orangeTopMiddle:
            textureLocation = orangeTopMiddle
        case .orangeTopRightCorner:
            textureLocation = orangeTopRightCorner
        case .orangeRightRidge:
            textureLocation = orangeRightRidge
        case .orangeLeftRidge:
            textureLocation = orangeLeftRidge
        case .orangeDustCenter:
            textureLocation = orangeDustCenter
        case .emptyDustCenter:
            textureLocation = emptyDustCenter
        case .orangeTopColumn:
            textureLocation = orangeTopColumn
        case .orangeMidColumn:
            textureLocation = orangeMidColumn
        case .grassOne:
            textureLocation = grassOne
        case .grassTwo:
            textureLocation = grassTwo
        case .grassThree:
            textureLocation = grassThree
        case .grassFour:
            textureLocation = grassFour
        case .rockLarge:
            textureLocation = rockLarge
        case .rockSmall:
            textureLocation = rockSmall
        }
        return textureLocation
    }
    
    func createSingleSpriteObject(from array: [[Int]]) -> SKSpriteNode {
        let size = CGSize(width: TileWidth * array[0].count, height: TileHeight * array.count)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        for (row, rowValue) in array.enumerated() {
            for (col, textureValue) in rowValue.enumerated() {
                if let groundType = BSGroundTextureType(rawValue: textureValue),
                    let textureLocation = getTextureLocation(with: groundType) {
                    let image = BSTextureStore.shared.groundTexture.getTextureFrom(col: textureLocation.col, row: textureLocation.row).cgImage()
                    context?.draw(image, in: CGRect(x: col * TileWidth, y: (array.count - row - 1) * TileHeight, width: TileWidth, height: TileHeight))
                }
            }
        }
        let tilesBackground = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let sprite = SKSpriteNode(texture: SKTexture.init(image: tilesBackground!), size: size)
        sprite.yScale = -1
        return sprite
    }
}
