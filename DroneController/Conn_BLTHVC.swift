import UIKit


class Conn_BLTHVC: UIViewController {
    
    @IBAction func dismiss(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
}