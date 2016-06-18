import UIKit
import CoreBluetooth

class Conn_BLTH: UIViewController,UITableViewDataSource, UITableViewDelegate, BluetoothSerialDelegate {
    
    @IBOutlet weak var btn_bluetooth: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    
    var selectedPeripheral: CBPeripheral?
    let textCellIdentifier = "cell"
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        serial = BluetoothSerial(delegate: self)
        serial.writeType = .WithoutResponse
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func dismiss(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    func serialDidReceiveString(message: String) {}
    
    func serialDidDisconnect(peripheral: CBPeripheral, error: NSError?) {
        
    }
    
    func serialIsReady(peripheral: CBPeripheral) {
       print("test " + "connect device 11")
        
         serial.sendMessageToDevice("send init data")
      
    }
    
    func serialDidChangeState(newState: CBCentralManagerState) {
        print("test " + "connect device 22")
    }

    
    @IBAction func scanBluetooth(sender: AnyObject) {
        serial.startScan()
        
        btn_bluetooth.enabled = false;
        btn_bluetooth.backgroundColor = UIColor.grayColor()
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
        
        print("test " + "select device")
        // the user has selected a peripheral, so stop scanning and proceed to the next view
        serial.stopScan()
        selectedPeripheral = peripherals[indexPath.row].peripheral
        serial.connectToPeripheral(selectedPeripheral!)
        
       
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
        testLabel.text = peripherals[0].peripheral.name;
    }

}