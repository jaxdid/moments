import CoreLocation
import Firebase
import MapKit
import UIKit

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  private let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments")
  @IBOutlet var map: MKMapView!
  var userCoordinate: CLLocationCoordinate2D!
  internal var locationManager: OneShotLocationManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    map.delegate = self
    momentsRef.observeEventType(.ChildAdded, withBlock: { snapshot in
      let latitude = snapshot.value.objectForKey("latitude") as! Double
      let longitude = snapshot.value.objectForKey("longitude") as! Double
      let text = snapshot.value.objectForKey("text") as! String
      let momoji = snapshot.value.objectForKey("momoji") as! String
      //let scalar = String(Character(UnicodeScalar(Int(momoji, radix: 16)!)))
      let moment = MapAnnotation(title: "\(text)",
                                 subtitle: snapshot.value.objectForKey("userName") as! String,
                                 coordinate: CLLocationCoordinate2DMake(latitude, longitude),
                                 momoji: momoji)
      
      self.map.addAnnotation(moment)
    })
    
    let test = MapAnnotation(title: "Test Anno",
                               subtitle: "This is a test",
                               coordinate: CLLocationCoordinate2DMake(0.0, 0.0),
                               momoji: "1F600")
    
    self.map.addAnnotation(test)
    
    var anView:MKAnnotationView = MKAnnotationView()
    anView.annotation = test
    anView.image = UIImage(named:"joy")
    anView.canShowCallout = true
    anView.enabled = true
    
    self.focusMapOnUser()
  }
  
  //=========================================================
  func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
    if (annotation is MKUserLocation) {
      //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
      //return nil so map draws default view for it (eg. blue dot)...
      return nil
    }
    
    let reuseId = "test"
    
    var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
    if anView == nil {
      anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      anView?.image = UIImage(named:"joy")
      anView?.canShowCallout = true
    }
    else {
      //we are re-using a view, update its annotation reference...
      anView?.annotation = annotation
    }
    
    return anView
  }
  //=========================================================

  
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