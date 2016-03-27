import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SignIn(sender: UIButton) {
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
                        } else {
                          print("Logged in! \(authData.uid)")
                          
//                          ref.createUser(authData.uid) { (error: NSError!) in
//                            if error == nil {
//                              self.ref.authUser(
//                                withCompletionBlock: { (error, auth) -> Void in
//                                  // 4
//                              })
//                            }
//                          }
                          
                          
                          
                            ref.observeAuthEventWithBlock { (authData) -> Void in
                              if authData != nil {
                                self.performSegueWithIdentifier("mapIdentifier", sender: nil)
                              }
                            }
                          
                            //self.performSegueWithIdentifier("mapIdentifier", sender: self)
                        }
                      
                })
            }
        })
    }
}
