import UIKit
import Firebase

class CreateMomentController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
  var latitude: Double!
  var longitude: Double!
  var authData: AnyObject!

  let characterLimit = 30
  private var selectedUnicode: String = ""
  let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments")
  var userId: String!
  
  @IBOutlet weak var pickerView: UIPickerView!
  @IBOutlet weak var textField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pickerView.delegate = self
    textField.delegate = self
    
    momentsRef.observeAuthEventWithBlock { authData in
      if authData != nil {
        self.userId = authData.uid
        print("User from Create Moment ctrl: \(self.userId)")
      }
    }
  }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 2
  }
  
  func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 70
  }
  
  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    
    var myImageView = UIImageView()
    
    switch row {
    case 0:
      myImageView = UIImageView(image: UIImage(named:"grinning_face"))
      selectedUnicode = "U+1F600"
    case 1:
      myImageView = UIImageView(image: UIImage(named:"joy"))
      selectedUnicode = "U+1F602"
    default:
      myImageView.image = nil
    }

    return myImageView
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else { return true }
    let newLength = text.characters.count + string.characters.count - range.length
    return newLength <= characterLimit
  }
  
  @IBAction func createMoment(sender: UIButton) {
    //print(self.pickerView.selectedRowInComponent(0))
    let moment = ["momoji": selectedUnicode,
                  "text": textField.text!,
                  "latitude": latitude,
                  "longitude": longitude,
                  "user": self.userId]
    let momentRef = momentsRef.childByAutoId()
    momentRef.setValue(moment)
    
    self.performSegueWithIdentifier("submitMoment", sender: nil)
  }
}




