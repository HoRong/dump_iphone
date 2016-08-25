//
//  GameScene.swift
//
//  Created by Dmitriy Mitrophanskiy on 28.09.14.
//  Copyright (c) 2014 Dmitriy Mitrophanskiy. All rights reserved.
//

import SpriteKit
import Foundation

class GameScene: SKScene {
    
    var img_joystick: [UIImage] = [UIImage(named: "joystick_ver1")!, UIImage(named: "joystick_ver2")!, UIImage(named: "joystick_ver1")!]
    var lData = CGPoint(x: 0.0, y: 0.0),rData = CGPoint(x: 0.0, y: 0.0)
    
    var moveAnalogStick =  🕹(diameters: (200, 35), colors: (UIColor.clearColor(), UIColor.whiteColor()), images: (UIImage(named: "joystick_ver1"), UIImage(named: "stick")))
    
    var rotateAnalogStick = AnalogJoystick(diameters: (200, 35),colors: (UIColor.clearColor(), UIColor.whiteColor()), images: (UIImage(named: "joystick_ver2"), UIImage(named: "stick")))
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        backgroundColor = UIColor.grayColor()
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        moveAnalogStick.position = CGPointMake(moveAnalogStick.radius + 35, moveAnalogStick.radius + 70)
        addChild(moveAnalogStick)
        
        rotateAnalogStick.position = CGPointMake(CGRectGetMaxX(self.frame) - rotateAnalogStick.radius - 35, rotateAnalogStick.radius + 70)
        addChild(rotateAnalogStick)
        
        //MARK: Handlers begin
        moveAnalogStick.trackingHandler = { [unowned self] data in
            self.lData = data.velocity
            var jData = ""
            
            jData += self.cgPointToString(self.lData.x)
            jData += self.cgPointToString(self.lData.y)
            jData += self.cgPointToString(self.rData.x)
            jData += self.cgPointToString(self.rData.y)
            
            print(jData)
        }
        
        
        
        moveAnalogStick.stopHandler = { [unowned self] in
            self.lData = CGPoint(x: 0.0, y: 0.0)
        }
        
        rotateAnalogStick.trackingHandler = { [unowned self] jData in
            self.rData = jData.velocity
            
        }
        
        rotateAnalogStick.stopHandler =  { [unowned self] in
            self.rData = CGPoint(x: 0.0, y: 0.0)
        }
        
        //MARK: Handlers end
        view.multipleTouchEnabled = true
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func getJoystickData() -> (String) {
    
        var jData = ""
      
        jData += cgPointToString(self.lData.x)
        jData += cgPointToString(self.lData.y)
        jData += cgPointToString(self.rData.x)
        jData += cgPointToString(self.rData.y)
        
        print(jData)
        
        return jData
    }
    
    func cgPointToString(point : CGFloat) -> (String){
        let numberOfPlaces = 0.0
        let multiplier = pow(10.0, numberOfPlaces)
        var num = Int(round(Double(point) * multiplier) / multiplier)
        num += 100
        
        return String(num)
    }
    
    func setJoystickMode(_mode: Int){
        
        switch _mode {
            
        case 0:
            moveAnalogStick.substrate.image = img_joystick[2]
            rotateAnalogStick.substrate.image = img_joystick[2]
            break
            
        case 1:
            moveAnalogStick.substrate.image = img_joystick[0]
            rotateAnalogStick.substrate.image = img_joystick[1]
            break
            
        case 2:
            moveAnalogStick.substrate.image = img_joystick[1]
            rotateAnalogStick.substrate.image = img_joystick[0]
            break
            
        default:
            break
        }
    }
}

