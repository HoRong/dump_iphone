//
//  MenuConnTrimVC.swift
//  DroneController
//

import UIKit


class MenuConnTrimVC: UIViewController {
    @IBAction func incompleteFuc(sender: AnyObject) {
        
        view.makeToast(message: "추후 추가될 기능입니다.")
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    

}