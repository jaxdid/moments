import UIKit
import MapKit
import AWSS3

extension MapController {
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    if (annotation is MKUserLocation) {
      return nil
    }
    
    let reuseId = "mapAnnotation"
    let customAnnotation = annotation as! MapAnnotation
    
    var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
    if annotationView == nil {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      switch customAnnotation.momoji {
      case "1F600":
        annotationView?.image = UIImage(named:"grinning_face")
      case "1F602":
        annotationView?.image = UIImage(named:"joy")
      default:
        annotationView?.image = UIImage(named:"grinning_face")
      }
      annotationView?.canShowCallout = true
    }
    else {
      annotationView?.annotation = annotation
    }
    
    configureDetailView(annotationView!, customAnnotation: customAnnotation)
    
    return annotationView
  }
  
  func configureDetailView(annotationView: MKAnnotationView, customAnnotation: MapAnnotation) {
    print (customAnnotation.imageKey)
    let width = 200
    let height = 300
    
    let snapshotView = UIView()
    let views = ["snapshotView": snapshotView]
    snapshotView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[snapshotView(200)]", options: [], metrics: nil, views: views))
    snapshotView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[snapshotView(300)]", options: [], metrics: nil, views: views))
    
    let options = MKMapSnapshotOptions()
    options.size = CGSize(width: width, height: height)
    options.mapType = .SatelliteFlyover
    options.camera = MKMapCamera(lookingAtCenterCoordinate: annotationView.annotation!.coordinate, fromDistance: 250, pitch: 65, heading: 0)
    
    if customAnnotation.imageKey != "no image" {
      let downloadingFilePath1 = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("temp-image")
      let downloadingFileURL1 = NSURL(fileURLWithPath: downloadingFilePath1 )
      let transferManager = AWSS3TransferManager.defaultS3TransferManager()
      
      let readRequest1 : AWSS3TransferManagerDownloadRequest = AWSS3TransferManagerDownloadRequest()
      readRequest1.bucket = "makersmoments"
      readRequest1.key = customAnnotation.imageKey
      readRequest1.downloadingFileURL = downloadingFileURL1
      
      let task = transferManager.download(readRequest1)
      task.continueWithBlock { (task) -> AnyObject! in
        if task.error != nil {
        } else {
          let code = dispatch_async(dispatch_get_main_queue()
            , { () -> Void in
              self.image = UIImage(contentsOfFile: downloadingFilePath1)
              let snapshotter = MKMapSnapshotter(options: options)
              snapshotter.startWithCompletionHandler { snapshot, error in
                if snapshot != nil {
                  let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                  imageView.image = self.image
                  snapshotView.addSubview(imageView)
                }
              }
              
              annotationView.detailCalloutAccessoryView = snapshotView
          })
        }
        return nil
      }
    }
  }
}