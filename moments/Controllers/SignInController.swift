import FBSDKCoreKit
import FBSDKLoginKit
import UIKit

class SignInController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func signIn(sender: UIButton) {
    print("Std User Defaults outside: \(NSUserDefaults.standardUserDefaults())")
    let facebookLogin = FBSDKLoginManager()
    facebookLogin.logInWithReadPermissions(["email"], handler: {
      (facebookResult, facebookError) -> Void in
      let errorHandler = facebookErrorHandler()
      errorHandler.handle(self, facebookResult: facebookResult, facebookError: facebookError)
    })
  }
  
//  func performSegue() {
//    self.performSegueWithIdentifier("signIn", sender: nil)
//  }
}
