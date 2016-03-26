import UIKit

class CreateMomentController: UIViewController {
    var latitude: Double!
    var longitude: Double!
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func click(sender: AnyObject) {
        label.text = "n\(latitude)"
    }
}
