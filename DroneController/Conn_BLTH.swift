import UIKit
import CoreBluetooth

class Conn_BLTH: UIViewController,UITableViewDataSource, UITableViewDelegate, BluetoothSerialDelegate {

    @IBOutlet weak var btn_bluetooth: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    
    var selectedPeripheral: CBPeripheral?
    let textCellIdentifier = "cell"
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        serial.delegate = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    /// Should be called 10s after we've begun scanning
    func scanTimeOut() {
        // timeout has occurred, stop scanning and give the user the option to try again
        
        view.makeToast(message: "Done Scanning", duration: 2, position: "center")
        serial.stopScan()
        
        btn_bluetooth.enabled = true
        btn_bluetooth.backgroundColor = UIColor.whiteColor()
    }
    
    /// Should be called 10s after we've begun connecting
    func connectTimeOut() {
        
        // don't if we've already connected
        if let _ = serial.connectedPeripheral {
            return
        }
    
        view.makeToast(message: "Connection Fail - Time out", duration: 2, position: "center")
    }

    func serialDidDisconnect(peripheral: CBPeripheral, error: NSError?) {
        view.makeToast(message: "Connection Fail - Disconnect")
    }
    
    func serialIsReady(peripheral: CBPeripheral) {
        view.makeToast(message: "Connection Succeed", duration: 2, position: "center")
        
        peripherals.removeAll()
        tableView.reloadData()
    
        serial.sendMessageToDevice("send init data")
    }
    
    func serialDidChangeState(newState: CBCentralManagerState) {
        /* 기기 블루투스 상태 변화할 때 호출되는 메소드*/
    }

    
    @IBAction func scanBluetooth(sender: AnyObject) {
        
        if serial.state != .PoweredOn {
            view.makeToast(message: "Bluetooth not turned on", duration: 2, position: "center")
            return
        }
        
        serial.startScan()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(Conn_BLTH.scanTimeOut), userInfo: nil, repeats: false)
        
        btn_bluetooth.enabled = false;
        btn_bluetooth.backgroundColor = UIColor.darkGrayColor()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // return a cell with the peripheral name as text in the label
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier)!
        
        let label = cell.viewWithTag(1) as! UILabel!
        label.text = peripherals[indexPath.row].peripheral.name

        return cell
    }
    
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // the user has selected a peripheral, so stop scanning and proceed to the next view
        serial.stopScan()
        btn_bluetooth.enabled = true;
        btn_bluetooth.backgroundColor = UIColor.whiteColor()
        selectedPeripheral = peripherals[indexPath.row].peripheral
        serial.connectToPeripheral(selectedPeripheral!)
        
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(Conn_BLTH.connectTimeOut), userInfo: nil, repeats: false)
       
    }
    
    func serialDidDiscoverPeripheral(peripheral: CBPeripheral, RSSI: NSNumber?) {
        // check whether it is a duplicate
        for exisiting in peripherals {
            if exisiting.peripheral.identifier == peripheral.identifier { return }
        }
        
        // add to the array, next sort & reload
        let theRSSI = RSSI?.floatValue ?? 0.0
        peripherals.append(peripheral: peripheral, RSSI: theRSSI)
        peripherals.sortInPlace { $0.RSSI < $1.RSSI }
        
        tableView.reloadData()
    }

}