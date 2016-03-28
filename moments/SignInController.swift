import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import UIKit

class SignInController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func signIn(sender: UIButton) {
    let ref = Firebase(url: "https://makersmoments.firebaseio.com")
    let facebookLogin = FBSDKLoginManager()
    facebookLogin.logInWithReadPermissions(["email"], handler: {
      (facebookResult, facebookError) -> Void in
      if facebookError != nil {
        print("Facebook login failed. Error \(facebookError)")
      } else if facebookResult.isCancelled {
        print("Facebook login was cancelled.")
      } else {
        let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
        ref.authWithOAuthProvider("facebook", token: accessToken,
          withCompletionBlock: { error, authData in
            if error != nil {
              print("Login failed. \(error)")
            } else if authData != nil {
              print("Logged in! \(authData)")
              ref.observeAuthEventWithBlock { (authData) -> Void in
                self.performSegueWithIdentifier("signIn", sender: nil)
              }
            }
          }
        )
      }
    })
  }
}
