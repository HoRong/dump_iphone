//
//  Set_SensiVC.swift
//  DroneController
//
import UIKit


class Set_SensiVC: UIViewController {
    
    @IBOutlet weak var btn_easy: UIButton!
    @IBOutlet weak var view_easy: UIView!
    @IBOutlet weak var btn_normal: UIButton!
    @IBOutlet weak var view_normal: UIView!
    @IBOutlet weak var btn_sport: UIButton!
    @IBOutlet weak var view_sport: UIView!
    
    @IBAction func dismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidLoad() {
        
        let idx: Int = DroneState.sharedInstance.getControlSensitivity()
        
        setControlSensitivityValue(idx)
    }
    
    @IBAction func onClickMode(sender: AnyObject) {
        setControlSensitivityValue(sender.tag)
    }
    
    
    func setControlSensitivityValue(idx: Int){
        
        switch idx {
        case 0:
            setSensitivityColor([view_easy, view_normal, view_sport])
            break
            
        case 1:
            setSensitivityColor([view_normal, view_easy, view_sport])
            break
            
        case 2:
            setSensitivityColor([view_sport, view_normal, view_easy])
            break
            
        default:
            break
        }
        
        DroneState.sharedInstance.setControlSensitivity(idx)
    }
    
    func setSensitivityColor(view: [UIView]){
        view[0].backgroundColor = UIColor.greenColor()
        view[1].backgroundColor = UIColor.darkGrayColor()
        view[2].backgroundColor = UIColor.darkGrayColor()
    }
}