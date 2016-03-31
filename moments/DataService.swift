import Foundation
import Firebase

class DataService {
  static let dataService = DataService()
  
  private var _BASE_REF = Firebase(url: "\(BASE_URL)")
  private var _MOMENT_REF = Firebase(url: "\(BASE_URL)/moments")
  
  var BASE_REF: Firebase {
    return _BASE_REF
  }
  
  var MOMENT_REF: Firebase {
    return _MOMENT_REF
  }
  
  var CURRENT_USER_REF: Firebase {
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    
    let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    
    return currentUser!
  }
}