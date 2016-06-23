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
    
    override func viewDidLoad() {
        
        initStateValue()
        activateVoltInstance(sw_volt.on)
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func ValueChanged(sender: UISwitch) {
        DroneState.sharedInstance.setAlertMode(sender.tag,_value: sender.on)
        
        if sender.tag ==  0{
            activateVoltInstance(sender.on)
        }
    }
    
    func initStateValue() {
        let value: [Bool] = DroneState.sharedInstance.getAlertState()
        let limit: Int = DroneState.sharedInstance.getLimit()
        
        sw_volt.setOn(value[0], animated: false)
        sw_marf.setOn(value[1], animated: false)
        sw_crash.setOn(value[2], animated: false)
        sw_area.setOn(value[3], animated: false)
        
        setLimitValue(limit)
    }
    
    
    @IBAction func limitValueChanged(sender: AnyObject) {

        let sliderModValue: Float = sender.value
        var sliderIntValue: Int = Int(sliderModValue)
        
        if (sliderModValue - Float(sliderIntValue)) >= 0.5 {
            sliderIntValue += 1
        }
        
        setLimitValue(sliderIntValue)
        print(sliderIntValue)
    }
    
    func setLimitValue(_limit: Int){
        tv_limit.text =  "\(_limit)%"
        sl_limit.value = Float(_limit)
        
        DroneState.sharedInstance.setLimit(_limit)
    }
    
    func activateVoltInstance(_value: Bool){
        
        sl_limit.enabled = _value
        tv_limit.enabled = _value
    }
    
    
}