//
//  GameScene.swift
//  FlappyBrids
//
//  Created by c.henrique.de.araujo on 28/01/20.
//  Copyright © 2020 c.henrique.de.araujo. All rights reserved.
//

import SpriteKit
import GameplayKit

let birdMask: UInt32 = 0x001
let wordMark: UInt32 = 0x010
let pipeMark: UInt32 = 0x100

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Morreu ")
        sprite.alpha = 0.2
    }
    
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
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.5)
        physicsWorld.contactDelegate = self
        
//        sprite.physicsBody?.restitution = 1
        physicsBody?.categoryBitMask = wordMark
        physicsBody?.contactTestBitMask = birdMask //checkpoint
        physicsBody?.collisionBitMask = birdMask
        
        sprite.physicsBody?.categoryBitMask = birdMask
        sprite.physicsBody?.contactTestBitMask = wordMark & pipeMark
        sprite.physicsBody?.collisionBitMask = wordMark
        
        
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if sprite.physicsBody!.velocity.dy < CGFloat(100) {
            sprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 5))
        }
        
    }
}
