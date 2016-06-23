//
//  Set_AlertVC.swift
//  DroneController
//
import UIKit


class Set_AlertVC: UIViewController {

    
    @IBOutlet weak var sl_limit: UISlider!
    @IBOutlet weak var tv_limit: UILabel!

    @IBOutlet weak var sw_volt: UISwitch!
    @IBOutlet weak var sw_marf: UISwitch!
    @IBOutlet weak var sw_crash: UISwitch!
    @IBOutlet weak var sw_area: UISwitch!
    
    @IBAction func dismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidLoad() {
        
        initStateValue()
        activateVoltInstance(sw_volt.on)
    }
    
    func initStateValue() {

        sw_volt.on = DroneState.sharedInstance.alertMode[0]
        
        sw_marf.on = DroneState.sharedInstance.alertMode[1]
        
        sw_crash.on = DroneState.sharedInstance.alertMode[2]
        
        sw_area.on = DroneState.sharedInstance.alertMode[3]
    }

    @IBAction func ValueChanged(sender: UISwitch) {
        DroneState.sharedInstance.setAlertMode(sender.tag,_value: sender.on)
        
        if sender.tag ==  0{
            activateVoltInstance(sender.on)
        }
    }
    
    func activateVoltInstance(_value: Bool){
        
        sl_limit.enabled = _value
        tv_limit.enabled = _value
    }
    
    
}