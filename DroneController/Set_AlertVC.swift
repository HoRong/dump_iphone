//
//  Set_AlertVC.swift
//  DroneController
//
import UIKit


class Set_AlertVC: UIViewController {

    @IBAction func dismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
}