import CoreLocation
import Firebase
import MapKit
import UIKit
import AWSS3

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  @IBOutlet var map: MKMapView!
  @IBOutlet weak var imageView: UIImageView!
  private let momentsRef = Firebase(url: MOMENTS_URL)
  private var locationManager: OneShotLocationManager?
  private var userCoordinate: CLLocationCoordinate2D!
  var image: UIImage!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    map.delegate = self
    momentsRef.observeEventType(.ChildAdded, withBlock: { snapshot in
      let moment = AnnotationBuilder().run(snapshot)
      self.map.addAnnotation(moment)
    })
    self.centerMapOnUser()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func centerMapOnUser() {
    locationManager = OneShotLocationManager()
    locationManager!.fetchWithCompletion {location, error in
      if let unwrappedLocation = location {
        self.userCoordinate = unwrappedLocation.coordinate
        MapViewUpdater().run(self.map, userCoordinate: unwrappedLocation.coordinate)
      } else if let err = error {
        print(err.localizedDescription)
      }
    }
  }
  
  func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
      completion(data: data, response: response, error: error)
      }.resume()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destinationController = segue.destinationViewController as? CreateMomentController {
      destinationController.userCoordinate = userCoordinate
    }
    segue.sourceViewController
  }
}