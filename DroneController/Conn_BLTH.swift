import UIKit
import CoreBluetooth

class Conn_BLTH: UIViewController,UITableViewDataSource, UITableViewDelegate, BluetoothSerialDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
    let textCellIdentifier = "cell"
    var selectedPeripheral: CBPeripheral?
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
      tableView.tableFooterView = UIView(frame: CGRectZero)
        
        serial = BluetoothSerial(delegate: self)
        serial.writeType = .WithoutResponse
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func serialDidReceiveString(message: String) {}
    
    func serialDidDisconnect(peripheral: CBPeripheral, error: NSError?) {
        
    }
    
    func serialDidChangeState(newState: CBCentralManagerState) {
        
    }

    
    @IBAction func scanBluetooth(sender: AnyObject) {
        serial.startScan()
        print(11);
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // return a cell with the peripheral name as text in the label
        
        print(22);
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier)!
        cell.textLabel?.text = peripherals[indexPath.row].peripheral.name

        return cell
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
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