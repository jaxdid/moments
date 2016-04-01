import UIKit
import CoreLocation

enum OneShotLocationManagerErrors: Int {
  case AuthorizationDenied
  case AuthorizationNotDetermined
  case InvalidLocation
}

class OneShotLocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
  
  deinit {
    locationManager?.delegate = nil
    locationManager = nil
  }
  
  typealias LocationClosure = ((location: CLLocation?, error: NSError?)->())
  private var didComplete: LocationClosure?
  
  private func _didComplete(location: CLLocation?, error: NSError?) {
    locationManager?.stopUpdatingLocation()
    didComplete?(location: location, error: error)
    locationManager?.delegate = nil
    locationManager = nil
  }
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    
    switch status {
    case .AuthorizedWhenInUse:
      self.locationManager!.startUpdatingLocation()
    case .Denied:
      _didComplete(nil, error: NSError(domain: self.classForCoder.description(),
        code: OneShotLocationManagerErrors.AuthorizationDenied.rawValue,
        userInfo: nil))
    default:
      break
    }
  }
  
  internal func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    _didComplete(nil, error: error)
  }
  
  internal func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[0]
    _didComplete(location, error: nil)
  }
  
  func fetchWithCompletion(completion: LocationClosure) {
    didComplete = completion
    
    locationManager = CLLocationManager()
    locationManager!.delegate = self
    locationManager!.desiredAccuracy = kCLLocationAccuracyBest
    
    if (NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationWhenInUseUsageDescription") != nil) {
      locationManager!.requestWhenInUseAuthorization()
    } else if (NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil) {
      locationManager!.requestAlwaysAuthorization()
    } else {
      fatalError("To use location in iOS8 you need to define either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription in the app bundle's Info.plist file")
    }
    
  }
}
