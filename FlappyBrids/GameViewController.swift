//
//  GameViewController.swift
//  FlappyBrids
//
//  Created by c.henrique.de.araujo on 28/01/20.
//  Copyright © 2020 c.henrique.de.araujo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = view as? SKView
        let scene = GameScene(size: view!.bounds.size)
        skView?.presentScene(scene)
    }

   
}
