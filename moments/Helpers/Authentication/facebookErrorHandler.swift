import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import UIKit

class facebookErrorHandler {
  func run(controller: SignInController, facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) {
    
    if facebookError != nil {
      print("Facebook login failed. Error \(facebookError)")
    } else if facebookResult.isCancelled {
      print("Facebook login was cancelled.")
    } else {
      FacebookOAuthHandler().run(controller)
    }
  }
}