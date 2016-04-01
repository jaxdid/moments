import FBSDKLoginKit
import Firebase

class FacebookOAuthHandler {
  func run(controller: SignInController) {
    let ref = Firebase(url: BASE_URL)
    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
    
    ref.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
      if error != nil {
        print("Login failed. \(error)")
      } else if authData != nil {
        print("Logged in! \(authData)")
        let currentUser = ["uid": authData.uid,
                       "name": authData.providerData["displayName"] as? String]
        //print("Current user before assignment: \(CURRENT_USER)")
        NSUserDefaults.standardUserDefaults().setObject(currentUser, forKey: "currentUser")
        //print("Current user after assignment: \(CURRENT_USER)")
        controller.performSegueWithIdentifier("signIn", sender: nil)
      }
    })
  }
}