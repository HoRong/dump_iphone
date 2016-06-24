//
//  Conn_TrimmVC.swift
//  DroneController
import UIKit
import CoreBluetooth

class Conn_TrimmVC: UIViewController, BluetoothSerialDelegate {

    var controlValue: Double = 0.05, rollValue = 0.5,picthValue = 1.2
    
    let head: Int = 116, tail: Int = 117
    
    @IBOutlet weak var btn_up: UIButton!
    @IBOutlet weak var btn_down: UIButton!
    @IBOutlet weak var btn_left: UIButton!
    @IBOutlet weak var btn_right: UIButton!

    @IBOutlet weak var tv_roll: UILabel!
    @IBOutlet weak var tv_pitch: UILabel!
    
    override func viewDidLoad() {
    
    }

    @IBAction func dismiss(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func sendAutoSignal(sender: AnyObject) {
        serial.sendMessageToDevice("\(head)1\(tail)")
    }
    
    @IBAction func sendManualRollSignal(sender: AnyObject) {
       
        if sender.tag == 1 {
            rollValue += controlValue
        }
        else {
            rollValue -= controlValue
        }

        rollValue = Double(round(1000*rollValue)/1000)
        tv_roll.text = trimValueToString(rollValue)
        serial.sendMessageToDevice("\(head) ROLL_TRIM \(rollValue)\(tail)")
    }
 
    @IBAction func sendManualPitchSignal(sender: AnyObject) {
        if sender.tag == 1 {
            picthValue += controlValue
        }
        else {
            picthValue -= controlValue
        }
        
        picthValue = Double(round(1000*picthValue)/1000)
        tv_pitch.text = trimValueToString(picthValue)
        serial.sendMessageToDevice("\(head) PITCH_TRIM \(picthValue)\(tail)")
    }
    
    @IBAction func controlValueChanged(sender: AnyObject) {
        switch sender.selectedSegmentIndex {
            
        case 0:
            controlValue = 0.05
            break
            
        case 1:
            controlValue = 0.1
            break
        
        case 2:
            controlValue = 0.5
            break
            
        default:
            break
        }
    }
    
    func trimValueToString(_value: Double) -> String{
       
        if _value < 0 {
            return "-      \(_value * -1)"
        }
        
        return "+      \(_value)"
        
    }
    
    func serialDidDisconnect(peripheral: CBPeripheral, error: NSError?) {
        view.makeToast(message: "Connection Fail - Disconnect")
    }
    
    func serialDidChangeState(newState: CBCentralManagerState) {
        /* 기기 블루투스 상태 변화할 때 호출되는 메소드*/
    }
    
}
