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
    }
  }
  
  func configureDetailView(annotationView: MKAnnotationView, customAnnotation: MapAnnotation) {
    let width = 166
    let height = 200
    
    let snapshotView = UIView()
    ConstraintAdder().run(snapshotView, width: width, height: height)
    
    let options = MKMapSnapshotOptions()
    OptionsAdder().run(options, width: width, height: height, annotationView: annotationView)
    
    downloadImage(customAnnotation.imageKey)
    if customAnnotation.imageKey != "no image" {
      let snapshotter = MKMapSnapshotter(options: options)
      snapshotter.startWithCompletionHandler { snapshot, error in
          ImageProcessor().run(snapshot, width: width, height: height, image: self.image, snapshotView: snapshotView)
      }
      annotationView.detailCalloutAccessoryView = snapshotView
    }
  }
}