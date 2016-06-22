
import Foundation

class DroneState {
    
    let stateName: [String] = ["JoystickMode", "ControlSensitivity",
    "aVolt", "aMarf", "aCrash", "aArea", "aLimit"];
    let defaults: NSUserDefaults
    
    var joystickMode: Int
    var controlSensitivity: Int
    var alertLimit: Int
    var alertMode: [Bool] = [true, true, true, true]

    
    init(){
        defaults = NSUserDefaults.standardUserDefaults()
        
        if let _: Int = defaults.integerForKey(stateName[0]){
            joystickMode = 0
            controlSensitivity = 0
            alertLimit = 10
        }
        
        else{
            
            joystickMode = defaults.integerForKey(stateName[0])
            controlSensitivity = defaults.integerForKey(stateName[1])
            
            alertMode[0] = defaults.boolForKey(stateName[2])
            alertMode[1] = defaults.boolForKey(stateName[3])
            alertMode[2] = defaults.boolForKey(stateName[4])
            alertMode[3] = defaults.boolForKey(stateName[5])
            
            alertLimit = defaults.integerForKey(stateName[6]);
        }
    }
    
    func getJoystickMode() -> Int{
        return self.joystickMode
    }
    
    func getControlSensitivity() -> Int{
        return self.controlSensitivity
    }
    
    func  getAlertState() -> ([Bool], Int) {
        return (alertMode, alertLimit)
    }
    
    func setJoystickMode(_value: Int){
        self.joystickMode = _value
    }
    
    func setControlSensitivity(_value: Int){
        self.controlSensitivity = _value
    }
    
    func setAlertMode(idx: Int, _value: Bool){
        self.alertMode[idx] = _value
    }
    
    func setLimit(_value: Int){
        self.alertLimit = _value
    }

}