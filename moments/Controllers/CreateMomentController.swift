import CoreLocation
import Firebase
import UIKit

class CreateMomentController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
  var userLocation: CLLocation!
  let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments")
  private let characterLimit = 30
  private var selectedMomoji = ""
  private var userId: String!
  @IBOutlet weak var pickerView: UIPickerView!
  @IBOutlet weak var textField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pickerView.delegate = self
    textField.delegate = self
    momentsRef.observeAuthEventWithBlock { authData in
      self.userId = authData.uid
    }
    self.hideKeyboardWhenTappedAround()
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
      selectedMomoji = "U+1F600"
    case 1:
      myImageView = UIImageView(image: UIImage(named:"joy"))
      selectedMomoji = "U+1F602"
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
    let moment = ["momoji": selectedMomoji,
                  "text": textField.text!,
                  "latitude": self.userLocation.coordinate.latitude,
                  "longitude": self.userLocation.coordinate.longitude,
                  "user": self.userId]
    let momentRef = momentsRef.childByAutoId()
    momentRef.setValue(moment)
  }
}