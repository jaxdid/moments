import AWSS3
import Firebase
import MapKit
import UIKit

extension MapController {
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments")
    
    if (annotation is MKUserLocation) {
      return nil
    }
    
    let customAnnotation = annotation as! MapAnnotation
    let reuseId = customAnnotation.momentId!
    
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
      
      momentsRef.observeAuthEventWithBlock { authData in
        if customAnnotation.uid == authData.uid {
          print("Moment owner: \(customAnnotation.uid)")
          print("Current user: \(authData.uid)")
          let btn = UIButton(type: .DetailDisclosure)
          //btn.setTitle("X", forState: Normal)
          annotationView?.rightCalloutAccessoryView = btn
        }
      }
    }
    else {
      annotationView?.annotation = annotation
    }
    
    configureDetailView(annotationView!, customAnnotation: customAnnotation)
    
    return annotationView
  }
  
  func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments")
    
    let customAnnotation = annotationView.annotation as! MapAnnotation
    let momentId = customAnnotation.momentId!
    let momentPathRef = Firebase(url: "\(momentsRef)/\(momentId)")
    
    if control == annotationView.rightCalloutAccessoryView {
      momentPathRef.removeValue()
      mapView.removeAnnotation(customAnnotation)
    }
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
      var download = downloadImage(customAnnotation.imageKey)
      let snapshotter = MKMapSnapshotter(options: options)
      snapshotter.startWithCompletionHandler { snapshot, error in
        if snapshot != nil {
          let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
          imageView.image = self.image
          snapshotView.addSubview(imageView)
        }
      }
      
      annotationView.detailCalloutAccessoryView = snapshotView
    }
  }
}