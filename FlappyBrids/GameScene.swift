//
//  GameScene.swift
//  FlappyBrids
//
//  Created by c.henrique.de.araujo on 28/01/20.
//  Copyright © 2020 c.henrique.de.araujo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var sprite: SKSpriteNode
    
    override init(size: CGSize) {
        sprite = SKSpriteNode(imageNamed: "bird-01")
        super.init(size:size)
        
//        sprite.anchorPoint = CGPoint(x: 0, y: 0)
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        
        sprite.setScale(3)
        addChild(sprite)
        loadAnimation()
        
        scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 1)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError( "init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
    }
    
    private func loadAnimation(){
        let texturesNames = ["bird-01", "bird-02", "bird-03", "bird-04"]
        var textures: [SKTexture] = []
        
        for name in texturesNames {
            let texture = SKTexture(imageNamed: name)
            texture.filteringMode = .nearest
            textures.append(texture)
        }
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        let repeatForever = SKAction.repeatForever(animation)
        sprite.run(repeatForever)
    }
}
