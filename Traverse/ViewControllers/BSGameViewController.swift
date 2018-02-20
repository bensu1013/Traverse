//
//  GameViewController.swift
//  Traverse
//
//  Created by Benjamin Su on 2/11/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import UIKit
import SpriteKit

class BSGameViewController: UIViewController {

    var skView: SKView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        let aspectRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        
        let sceneView = SKView(frame: self.view.frame)
        
        let scene = BSGameScene(size: CGSize(width: 896 * aspectRatio, height: 896))
        scene.scaleMode = .aspectFill
        sceneView.presentScene(scene)
        sceneView.ignoresSiblingOrder = true
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        view.addSubview(sceneView)
        
        skView = sceneView
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
