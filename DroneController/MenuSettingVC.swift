//
//  MenuSettingVC.swift
//  DroneController

import UIKit


class MenuSettingVC: UIViewController {
    @IBAction func incompleteFunc(sender: AnyObject) {
    }

    @IBAction func dismiss(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
}
