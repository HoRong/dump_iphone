//
//  Set_JoystickVC.swift
//  DroneController
//
import UIKit


class Set_JoystickVC: UIViewController {

    var img_joystick: [UIImage] = [UIImage(named: "joystick_ver1")!, UIImage(named: "joystick_ver2")!, UIImage(named: "joystick_ver1")!]
    
    @IBOutlet weak var view_mode1: UIView!
    @IBOutlet weak var view_mode2: UIView!
    @IBOutlet weak var view_mode3: UIView!
    
    @IBOutlet weak var iv_leftJoystick: UIImageView!
    @IBOutlet weak var iv_rightJoystick: UIImageView!
    
    @IBOutlet weak var tv_mode: UILabel!
    
    @IBAction func dismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidLoad() {
        
        let idx: Int = DroneState.sharedInstance.getJoystickMode()
        setJoystickValue(idx)
    }
    
    @IBAction func onClickMode(sender: AnyObject) {
        setJoystickValue(sender.tag)
    }
    
    func setJoystickValue(idx: Int){
        
        switch idx {
        case 0:
            setJoystickModeImage(2,_right: 2)
            setSensitivityColor([view_mode1, view_mode2, view_mode3])
            break
            
        case 1:
            setJoystickModeImage(0,_right: 1)
            setSensitivityColor([view_mode2, view_mode1, view_mode3])
            break
            
        case 2:
            setJoystickModeImage(1,_right: 0)
            setSensitivityColor([view_mode3, view_mode2, view_mode1])
            break
            
        default:
            break
        }
        
        tv_mode.text = "조이스틱 모드 \(idx+1)"
        DroneState.sharedInstance.setJoystickMode(idx)
    }
    
    func setSensitivityColor(view: [UIView]){
        view[0].backgroundColor = UIColor.greenColor()
        view[1].backgroundColor = UIColor.darkGrayColor()
        view[2].backgroundColor = UIColor.darkGrayColor()
    }
    
    func setJoystickModeImage(_left: Int, _right: Int){
        iv_leftJoystick.image = img_joystick[_left]
        iv_rightJoystick.image = img_joystick[_right]
    }
}