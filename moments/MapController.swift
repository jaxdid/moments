import CoreLocation
import Firebase
import MapKit
import UIKit

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  @IBOutlet var map: MKMapView!
  var userCoordinate: CLLocationCoordinate2D!
  internal var locationManager: OneShotLocationManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.focusMapOnUser()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func focusMapOnUser() {
    locationManager = OneShotLocationManager()
    locationManager!.fetchWithCompletion {location, error in
      if let unwrappedLocation = location {
        self.userCoordinate = unwrappedLocation.coordinate
        self.setMapView(self.userCoordinate)
      } else if let err = error {
        print(err.localizedDescription)
      }
    }
  }
  
  private func setMapView(userCoordinate: CLLocationCoordinate2D) {
    let latitude = userCoordinate.latitude
    let longitude = userCoordinate.longitude
    let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    let viewRadius: CLLocationDegrees = 0.001
    let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(viewRadius, viewRadius))
    self.map.setRegion(region, animated: true)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destinationController = segue.destinationViewController as? CreateMomentController {
      destinationController.userCoordinate = userCoordinate
    }
    segue.sourceViewController
  }  
}