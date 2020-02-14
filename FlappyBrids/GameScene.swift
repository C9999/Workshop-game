//
//  GameScene.swift
//  FlappyBrids
//
//  Created by c.henrique.de.araujo on 28/01/20.
//  Copyright © 2020 c.henrique.de.araujo. All rights reserved.
//

import SpriteKit
import GameplayKit

let birdMask: UInt32 = 1
let wordMask: UInt32 = 2
let pipeMask: UInt32 = 4

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let scene = GameScene(size: size)
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 2)
        view?.presentScene(scene, transition: transition)
    }
    
    var bird: SKSpriteNode
    
    override init(size: CGSize) {
        bird = SKSpriteNode(imageNamed: "PipeUp")
        super.init(size:size)

        bird.position = CGPoint(x: size.width / 2, y: size.height / 2)
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
        bird.setScale(2)
        addChild(bird)
        loadAnimation()
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.5)
        physicsWorld.contactDelegate = self

        physicsBody?.categoryBitMask = wordMask
        physicsBody?.contactTestBitMask = birdMask //checkpoint
        physicsBody?.collisionBitMask = birdMask
        
        bird.physicsBody?.categoryBitMask = birdMask
        bird.physicsBody?.contactTestBitMask = wordMask & pipeMask
        bird.physicsBody?.collisionBitMask = wordMask & pipeMask
        
        let spawn = SKAction.run {
            self.spawnPipe()
        }
        let wait = SKAction.wait(forDuration: 1.5)
        let sequence = SKAction.sequence([spawn, wait])
        let repeatForever = SKAction.repeatForever(sequence)
        self.run(repeatForever)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError( "init(coder:) has not been implemented")
    }
    
    func createPipe(height: CGFloat, imageNamed: String) -> SKSpriteNode {
        let pipe = SKSpriteNode(imageNamed: imageNamed)
        pipe.position = CGPoint(x: size.width * 1.1, y: height)
        pipe.physicsBody = SKPhysicsBody(rectangleOf: pipe.size)
        pipe.physicsBody?.isDynamic = false
        pipe.setScale(2)
        addChild(pipe)

        pipe.physicsBody?.categoryBitMask = pipeMask
        pipe.physicsBody?.contactTestBitMask = birdMask
        pipe.physicsBody?.collisionBitMask = birdMask

        return pipe
    }
    
    func spawnPipe() {
    //        let height = CGFloat.random(in: 0...(size.height * 0.1))
    //        let distance: CGFloat = 100
    //        let pipeDownHeight = size.height - height - distance
            let pipeUpHeight = CGFloat.random(in: (size.height * 0.05)...(size.height * 0.2))
            let pipeDownHeight = CGFloat.random(in: (size.height * 0.95)...(size.height * 0.99))
            let pipeUp = createPipe(height: pipeUpHeight, imageNamed: "bird-01")
            let pipeDown = createPipe(height: pipeDownHeight, imageNamed: "bird-01")

            let move = SKAction.moveTo(x: -100, duration: 3)
            let removeFromScene = SKAction.run {
                pipeUp.removeFromParent()
                pipeDown.removeFromParent()
            }
            let sequence = SKAction.sequence([move, removeFromScene])
            pipeDown.run(move)
            pipeUp.run(sequence)
        }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
    }
    
    private func loadAnimation(){
        let texturesNames = ["PipeUp", "PipeDown", "PipeUp", "PipeDown"]
        var textures: [SKTexture] = []
        
        for name in texturesNames {
            let texture = SKTexture(imageNamed: name)
            texture.filteringMode = .nearest
            textures.append(texture)
        }
        let animation = SKAction.animate(with: textures, timePerFrame: 0.2)
        let repeatForever = SKAction.repeatForever(animation)
        bird.run(repeatForever)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bird.physicsBody!.velocity.dy < CGFloat(100) {
            bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 5))
        }
        
    }
}
