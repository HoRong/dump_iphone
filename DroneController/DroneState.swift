
import Foundation

class DroneState {
    
    static let sharedInstance = DroneState();
    
    let stateName: [String] = ["JoystickMode", "ControlSensitivity",
    "aVolt", "aMarf", "aCrash", "aArea", "aLimit"];
    let defaults: NSUserDefaults
    
    var joystickMode: Int
    var controlSensitivity: Int
    var alertLimit: Int
    var alertMode: [Bool] = [true, true, true, true]

    init(){
        defaults = NSUserDefaults.standardUserDefaults()

        if defaults.objectForKey(stateName[0]) == nil {
            
            joystickMode = 2
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
    
    func saveDroneState() {
        defaults.setInteger(joystickMode, forKey: stateName[0])
        defaults.setInteger(controlSensitivity, forKey: stateName[1])
        
        defaults.setBool(alertMode[0], forKey: stateName[2])
        defaults.setBool(alertMode[1], forKey: stateName[3])
        defaults.setBool(alertMode[2], forKey: stateName[4])
        defaults.setBool(alertMode[3], forKey: stateName[5])
        defaults.setInteger(alertLimit, forKey: stateName[6])
        defaults.synchronize()
    }
    
    func getJoystickMode() -> Int{
        return self.joystickMode
    }
    
    func getControlSensitivity() -> Int{
        return self.controlSensitivity
    }
    
    func  getAlertState() -> [Bool] {
        return alertMode
    }
    
    func getLimit() -> Int {
        return alertLimit
    }
    
    func setJoystickMode(_value: Int){
        self.joystickMode = _value
        saveDroneState()
    }
    
    func setControlSensitivity(_value: Int){
        self.controlSensitivity = _value
        saveDroneState()
    }
    
    func setAlertMode(idx: Int, _value: Bool){
        self.alertMode[idx] = _value
        saveDroneState()
    }
    
    func setLimit(_value: Int){
        self.alertLimit = _value
        saveDroneState()
    }

}