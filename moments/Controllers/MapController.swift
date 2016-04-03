import CoreLocation
import Firebase
import MapKit
import UIKit
import AWSS3

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  @IBOutlet var map: MKMapView!
  @IBOutlet weak var imageView: UIImageView!
  private var momentsRef: Firebase!
  private var addedHandle, removedHandle: UInt!
  private var locationManager: OneShotLocationManager?
  var userCoordinate: CLLocationCoordinate2D!
  var image: UIImage!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    map.delegate = self
    momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments")
    self.centerMapOnUser()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    addedHandle = momentsRef.observeEventType(.ChildAdded, withBlock: { snapshot in
      print("Moment ADDED!")
      let moment = AnnotationBuilder().run(snapshot)
      self.map.addAnnotation(moment)
    })
    
    removedHandle = momentsRef.observeEventType(.ChildRemoved, withBlock: { snapshot in
      print("Moment DELETED!")
      for annotation in self.map.annotations {
        if annotation is MKUserLocation || (annotation as! MapAnnotation).momentId == snapshot.key {
          self.map.removeAnnotation(annotation)
        }
      }
    })
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    momentsRef.removeObserverWithHandle(addedHandle)
    momentsRef.removeObserverWithHandle(removedHandle)
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