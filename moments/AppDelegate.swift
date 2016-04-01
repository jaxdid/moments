import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import AWSCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var keys: NSDictionary?
  
  func applicationWillResignActive(application: UIApplication) {
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
  }
  
  func applicationWillTerminate(application: UIApplication) {
  }
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    if let path = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist") {
        keys = NSDictionary(contentsOfFile: path)
    }
    let credentialsProvider = AWSCognitoCredentialsProvider(
        regionType: AWSRegionType.EUWest1, identityPoolId: "eu-west-1:62c2ee3e-db6d-4210-8706-e9895676885a")
    
    let defaultServiceConfiguration = AWSServiceConfiguration(
        region: AWSRegionType.EUWest1, credentialsProvider: credentialsProvider)
    
    AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = defaultServiceConfiguration
    
    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    FBSDKAppEvents.activateApp()
  }
  
  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url,
      sourceApplication: sourceApplication, annotation: annotation)
  }
}

