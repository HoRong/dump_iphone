//
//  ViewController.swift
//  DroneController
//
//  Created by JangChorong on 2016. 5. 26..
//  Copyright © 2016년 Aerodyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btn_connecting(sender: AnyObject) {
        
        if let uvc = self.storyboard?.instantiateViewControllerWithIdentifier("MenuConnTrimVC"){
            
            self.presentViewController(uvc, animated: false, completion: nil)
        }
        
    }
    
    @IBAction func btn_setting(sender: AnyObject) {
        if let uvc = self.storyboard?.instantiateViewControllerWithIdentifier("MenuSettingVC"){
        
            self.presentViewController(uvc, animated: false, completion: nil)
        }
        
    }

}

