import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  @IBOutlet var map: MKMapView!
  var locationManager = OneShotLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    focusMapOnUser()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func focusMapOnUser() {
    locationManager.fetchWithCompletion {location, error in
      if let userLocation = location {
        self.setMapView(userLocation)
      } else if let err = error {
        print(err.localizedDescription)
      }
    }
  }
  
  func setMapView(userLocation: CLLocation) {
    let latitude = userLocation.coordinate.latitude
    let longitude = userLocation.coordinate.longitude
    let location = CLLocationCoordinate2DMake(latitude, longitude)
    let viewRadius: CLLocationDegrees = 0.001
    let region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(viewRadius, viewRadius))
    self.map.setRegion(region, animated: true)
  }
}