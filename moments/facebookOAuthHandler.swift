import FBSDKLoginKit
import Firebase

class FacebookOAuthHandler {
  func handle(controller: SignInController) {
    let ref = Firebase(url: "https://makersmoments.firebaseio.com")
    let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
    
    ref.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
      if error != nil {
        print("Login failed. \(error)")
      } else if authData != nil {
        print("Logged in! \(authData)")
        
        let currentUser = ["uid": authData.uid,
                       "name": authData.providerData["displayName"] as? String]
        
        NSUserDefaults.standardUserDefaults().setObject(currentUser, forKey: "currentUser")
        
        
        
        
        print("Std User Defaults inside: \(NSUserDefaults.standardUserDefaults().objectForKey("currentUser"))")
        
        controller.performSegueWithIdentifier("signIn", sender: nil)
      }
    })
  }
}