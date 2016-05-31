//
//  Conn_DroneVC.swift
//  DroneController
import UIKit


class Conn_DroneVC: UIViewController {
    
    @IBAction func dismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
}
