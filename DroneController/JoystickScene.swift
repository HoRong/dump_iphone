//
//  GameScene.swift
//
//  Created by Dmitriy Mitrophanskiy on 28.09.14.
//  Copyright (c) 2014 Dmitriy Mitrophanskiy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var lData = CGPoint(x: 0.0, y: 0.0),rData = CGPoint(x: 0.0, y: 0.0)
    var appleNode: SKSpriteNode?
    
    let moveAnalogStick =  🕹(diameters: (220, 35), colors: (UIColor.clearColor(), UIColor.whiteColor()), images: (UIImage(named: "joystick_ver1"), UIImage(named: "stick")))
    
    let rotateAnalogStick = AnalogJoystick(diameters: (220, 35),colors: (UIColor.clearColor(), UIColor.whiteColor()), images: (UIImage(named: "joystick_ver2"), UIImage(named: "stick")))
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        backgroundColor = UIColor.grayColor()
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        moveAnalogStick.position = CGPointMake(moveAnalogStick.radius + 35, moveAnalogStick.radius + 70)
        addChild(moveAnalogStick)
        
        rotateAnalogStick.position = CGPointMake(CGRectGetMaxX(self.frame) - rotateAnalogStick.radius - 35, rotateAnalogStick.radius + 70)
        addChild(rotateAnalogStick)
        
        //MARK: Handlers begin
        
        moveAnalogStick.startHandler = { [unowned self] in
            
            guard let aN = self.appleNode else { return }
            aN.runAction(SKAction.sequence([SKAction.scaleTo(0.5, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)]))
        }
        
        moveAnalogStick.trackingHandler = { [unowned self] data in
            
            guard let aN = self.appleNode else { return }
            aN.position = CGPointMake(aN.position.x + (data.velocity.x * 0.12), aN.position.y + (data.velocity.y * 0.12))
            
            self.lData = data.velocity
        }
        
        moveAnalogStick.stopHandler = { [unowned self] in
            
            guard let aN = self.appleNode else { return }
            aN.runAction(SKAction.sequence([SKAction.scaleTo(1.5, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)]))
            self.lData = CGPoint(x: 0.0, y: 0.0)
        }
        
        rotateAnalogStick.trackingHandler = { [unowned self] jData in
            
            self.appleNode?.zRotation = jData.angular
            
            self.rData = jData.velocity
            
        }
        
        rotateAnalogStick.stopHandler =  { [unowned self] in
            
            guard let aN = self.appleNode else { return }
            aN.runAction(SKAction.rotateByAngle(3.6, duration: 0.5))
        
            self.rData = CGPoint(x: 0.0, y: 0.0)
        }
        
        //MARK: Handlers end

        addApple(CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)))
        
        view.multipleTouchEnabled = true
    }
    
    func addApple(position: CGPoint) {
        
        guard let appleImage = UIImage(named: "apple") else { return }
        
        let texture = SKTexture(image: appleImage)
        let apple = SKSpriteNode(texture: texture)
        if #available(iOS 8.0, *) {
            apple.physicsBody = SKPhysicsBody(texture: texture, size: apple.size)
            apple.physicsBody!.affectedByGravity = false
        } else {
            // Fallback on earlier versions
        }
        
        insertChild(apple, atIndex: 0)
        apple.position = position
        appleNode = apple
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func getJoystickData() -> (left: CGPoint, right: CGPoint) {
        
        return (lData, rData)
    }
}

