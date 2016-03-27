import CoreLocation
import Firebase
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  let locationManager = CLLocationManager()
  var userLocation: CLLocation!
  
  @IBOutlet var map: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    userLocation = locations[0]
    let latitude = userLocation.coordinate.latitude
    let longitude = userLocation.coordinate.longitude
    let latDelta: CLLocationDegrees = 0.001
    let longDelta: CLLocationDegrees = 0.001
    let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
    let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
    let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
    map.setRegion(region, animated: true)
    map.showsUserLocation = true
    locationManager.stopUpdatingLocation()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destinationController = segue.destinationViewController as? CreateMomentController {
      destinationController.userLocation = userLocation
    }
    segue.sourceViewController
  }
}