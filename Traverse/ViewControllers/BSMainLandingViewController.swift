//
//  BSMainLandingViewController.swift
//  Traverse
//
//  Created by Benjamin Su on 2/11/18.
//  Copyright © 2018 Benjamin Su. All rights reserved.
//

import UIKit

class BSMainLandingViewController: UIViewController {
    
    var startGameButton: UIButton!
    
    override func viewDidLoad() {
        view.backgroundColor = .green
        
        startGameButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        startGameButton.addTarget(nil, action: #selector(startGame), for: .touchUpInside)
        startGameButton.backgroundColor = .black
        view.addSubview(startGameButton)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    @objc func startGame() {
        let gameVC = BSGameViewController()
        self.present(gameVC, animated: true) {
            
        }
    }
    
}
