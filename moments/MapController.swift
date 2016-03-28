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
    momentsRef.observeEventType(.ChildAdded, withBlock: { snapshot
      in
      let moment = MKPointAnnotation()
      let a = snapshot.value.objectForKey("latitude")
      let b = snapshot.value.objectForKey("longitude")
      let latitude: CLLocationDegrees = (a as? Double)!
      let longitude: CLLocationDegrees = (b as? Double)!
      let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
      moment.coordinate = location
      let c = snapshot.value.objectForKey("text")
      let momoji = snapshot.value.objectForKey("momoji") as! String
      let cut = momoji.substringWithRange(Range<String.Index>(start: momoji.startIndex.advancedBy(2), end: momoji.endIndex.advancedBy(0)))
      print(cut)
      let scalar = String(Character(UnicodeScalar(Int(cut, radix: 16)!)))
      moment.title = "\(scalar)"
      moment.subtitle = self.userName
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