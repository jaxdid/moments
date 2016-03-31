import AWSS3
import Firebase
import MapKit
import UIKit

extension MapController {
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    
    if (annotation is MKUserLocation) {
      return nil
    }
    
    let customAnnotation = annotation as! MapAnnotation
    let reuseId = customAnnotation.momentId!
    
    let annotationView = BuildAnnotationView().run(mapView, reuseId: reuseId, annotation: annotation, customAnnotation: customAnnotation)
    
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
    let width = 5
    let height = 5
    
    let snapshotView = UIView()
    let views = ["snapshotView": snapshotView]
    snapshotView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[snapshotView(\(width))]", options: [], metrics: nil, views: views))
    snapshotView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[snapshotView(\(height))]", options: [], metrics: nil, views: views))
    
    let options = MKMapSnapshotOptions()
    options.size = CGSize(width: width, height: height)
    options.mapType = .SatelliteFlyover
    options.camera = MKMapCamera(lookingAtCenterCoordinate: annotationView.annotation!.coordinate, fromDistance: 250, pitch: 65, heading: 0)
    
    downloadImage(customAnnotation.imageKey)
    if customAnnotation.imageKey != "no image" {
      let snapshotter = MKMapSnapshotter(options: options)
      snapshotter.startWithCompletionHandler { snapshot, error in
        if snapshot != nil {
          let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
          imageView.image = self.image
            let textView = UILabel()
            textView.text = "hello"
            snapshotView.addSubview(textView)
            
        }
      }
      annotationView.detailCalloutAccessoryView = snapshotView
    }
  }
}