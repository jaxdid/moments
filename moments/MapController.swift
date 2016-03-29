import CoreLocation
import Firebase
import MapKit
import UIKit
import AWSS3

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  private let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments")
  @IBOutlet var map: MKMapView!
  var userCoordinate: CLLocationCoordinate2D!
  internal var locationManager: OneShotLocationManager?
  var image: UIImage!
  
  @IBOutlet weak var imageVIew: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    imageVIew.imageFromUrl("http://s3.amazonaws.com/makersmoments/19DE1592-2C72-45D6-BCBE-FEEFBD322CA1-2254-000004110A03C53C.jpg")
    map.delegate = self
    momentsRef.observeEventType(.ChildAdded, withBlock: { snapshot in
      let latitude = snapshot.value.objectForKey("latitude") as! Double
      let longitude = snapshot.value.objectForKey("longitude") as! Double
      let text = snapshot.value.objectForKey("text") as! String
      let momoji = snapshot.value.objectForKey("momoji") as! String
      // =====================================================================================
      let downloadingFilePath1 = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("temp-image")
      let downloadingFileURL1 = NSURL(fileURLWithPath: downloadingFilePath1 )
      let transferManager = AWSS3TransferManager.defaultS3TransferManager()
      
      let readRequest1 : AWSS3TransferManagerDownloadRequest = AWSS3TransferManagerDownloadRequest()
      readRequest1.bucket = "makersmoments"
      readRequest1.key =  snapshot.value.objectForKey("imageKey") as! String
      readRequest1.downloadingFileURL = downloadingFileURL1
      
      let task = transferManager.download(readRequest1)
      task.continueWithBlock { (task) -> AnyObject! in
        if task.error != nil {
        } else {
          let code = dispatch_async(dispatch_get_main_queue()
            , { () -> Void in
              self.image = UIImage(contentsOfFile: downloadingFilePath1)
//              self.selectedImage.setNeedsDisplay()
//              self.selectedImage.reloadInputViews()
          })
        }
        return nil
      }
      // =====================================================================================
      let moment = MapAnnotation(title: "\(text)",
                                 subtitle: snapshot.value.objectForKey("userName") as! String,
                                 coordinate: CLLocationCoordinate2DMake(latitude, longitude),
                                 momoji: momoji)
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
  
  func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
      completion(data: data, response: response, error: error)
      }.resume()
  }
  
  func downloadImage(url: NSURL){
    print("Download Started")
    print("lastPathComponent: " + (url.lastPathComponent ?? ""))
    getDataFromUrl(url) { (data, response, error)  in
      dispatch_async(dispatch_get_main_queue()) { () -> Void in
        guard let data = data where error == nil else { return }
        print(response?.suggestedFilename ?? "")
        print("Download Finished")
        self.image = UIImage(data: data)
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