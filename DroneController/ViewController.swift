//
//  ViewController.swift
//  DroneController
//
//  Created by JangChorong on 2016. 5. 26..
//  Copyright © 2016년 Aerodyn. All rights reserved.
//

import UIKit
import SpriteKit
import CoreBluetooth

class ViewController: UIViewController, BluetoothSerialDelegate {

    @IBOutlet weak var btn_start: UIButton!
    @IBOutlet weak var timestamp: UILabel!
    var tTimer = NSTimer() /* For Time Change */
    var bTimer = NSTimer() /* For send Message To BLE Device */
    
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DroneState.sharedInstance;
      
        // init serial
        serial = BluetoothSerial(delegate: self)
        serial.writeType = .WithoutResponse
        
        scene = GameScene(size: self.view.bounds.size)
        scene.backgroundColor = .whiteColor()
        
        if let skView = self.view as? SKView {
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            /* Set the scale mode to scale to fit the window */
            //scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }else {
            print(2)
        }
    }
    

    override func viewWillAppear(animated: Bool) {
        
        tTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.setTimestamp), userInfo: nil, repeats: true)
        
        if(serial.isReady) {
            bTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(ViewController.sendJoysticState), userInfo: nil, repeats: true)
        }
        print(DroneState.sharedInstance.getJoystickMode())
        scene.setJoystickMode(DroneState.sharedInstance.getJoystickMode())
    }
    
    override func viewDidDisappear(animated: Bool) {
        tTimer.invalidate()
        if bTimer.valid { bTimer.invalidate() }
        
        
    }
    
    func setTimestamp(){
        let _timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        timestamp.text = _timestamp
    }
    
    func sendJoysticState(){
        let jdata = scene.getJoystickData()
        serial.sendMessageToDevice("\(jdata)");
        print(jdata)
    }
    
    @IBAction func onClickStart(sender: AnyObject) {
       
        if(btn_start.tag != 1 ){
            btn_start.setTitle("STOP", forState: UIControlState.Normal)
            btn_start.backgroundColor = UIColor.redColor()
            btn_start.tag = 1
        }
        else {
            btn_start.setTitle("START", forState: UIControlState.Normal)
            btn_start.backgroundColor = UIColor.greenColor()
            btn_start.tag = 0
        }
    }
    
    func serialDidReceiveString(message: String) {
        // add the received text to the textView, optionally with a line break at the end
        print(message)
        
        
        /* 기기로부터 메세지 받은 것....*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func serialDidDisconnect(peripheral: CBPeripheral, error: NSError?) {
        view.makeToast(message: "Connection Fail - Disconnect")
    }
    
    
    func serialDidChangeState(newState: CBCentralManagerState) {
        /* 기기 블루투스 상태 변화할 때 호출되는 메소드*/
    }
}

