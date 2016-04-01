import CoreLocation
import Firebase
import UIKit
import AWSCore
import AWSS3
import AWSCognito
import AssetsLibrary

class CreateMomentController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var pickerView: UIPickerView!
  @IBOutlet weak var textField: UITextField!
  var userCoordinate: CLLocationCoordinate2D!
  private let momentsRef = Firebase(url: MOMENTS_URL)
  private var uid = NSUserDefaults.standardUserDefaults().objectForKey("currentUser")?["uid"]!!
  private var username = NSUserDefaults.standardUserDefaults().objectForKey("currentUser")?["name"]!!
  internal var selectedMomoji: String!
  private let characterLimit = 30
  private let imagePicker = UIImagePickerController()
  internal let uploadRequest = AWSS3TransferManagerUploadRequest()

  override func viewDidLoad() {
    super.viewDidLoad()
    pickerView.delegate = self
    textField.delegate = self
    imagePicker.delegate = self
    self.textFieldShouldReturn(textField)
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else { return true }
    let newLength = text.characters.count + string.characters.count - range.length
    return newLength <= characterLimit
  }
  
  @IBAction func createMoment(sender: UIButton) {
    let currentTime = Formatter().currentTime()
    let moment = Moment().build(selectedMomoji,
                  text: textField.text!,
                  latitude: userCoordinate.latitude,
                  longitude: userCoordinate.longitude,
                  userName: username!,
                  uid: uid!,
                  timestamp: currentTime,
                  imageKey: ImageKeyValidator().run(uploadRequest))
    
    let momentRef = momentsRef.childByAutoId()
    momentRef.setValue(moment)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    SaveToTemporaryDirectory().run(self, pickedImage: pickedImage, uploadRequest: uploadRequest)
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    }
  }
  
  @IBAction func takePhoto(sender: AnyObject) {
    imagePicker.allowsEditing = false
    imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
    imagePicker.cameraCaptureMode = .Photo
    imagePicker.modalPresentationStyle =  .FullScreen
    presentViewController(imagePicker, animated: true, completion: nil)
  }
}