import CoreLocation
import Firebase
import MapKit
import UIKit

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  private let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments")
  @IBOutlet var map: MKMapView!
  var userCoordinate: CLLocationCoordinate2D!
  var userName: String!
  internal var locationManager: OneShotLocationManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    momentsRef.observeAuthEventWithBlock { authData in
      self.userName = authData.providerData["displayName"] as? String
    }
    momentsRef.observeEventType(.ChildAdded, withBlock: { snapshot in
      let moment = MKPointAnnotation()
      let latitude = snapshot.value.objectForKey("latitude") as! Double
      let longitude = snapshot.value.objectForKey("longitude") as! Double
      let text = snapshot.value.objectForKey("text") as! String
      let momoji = snapshot.value.objectForKey("momoji") as! String
      let scalar = String(Character(UnicodeScalar(Int(momoji, radix: 16)!)))
      moment.title = "\(text) \(scalar)"
      moment.subtitle = self.userName
      moment.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
      self.map.addAnnotation(moment)
    })
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