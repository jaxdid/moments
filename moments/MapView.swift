import Firebase
import MapKit
import UIKit


extension MapController {
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments-12")
    
    if (annotation is MKUserLocation) {
      return nil
    }
    
    let reuseId = "mapAnnotation"
    
    var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
    if annotationView == nil {
      let customAnnotation = annotation as! MapAnnotation
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
          print("[Inside] Moment owner: \(customAnnotation.uid)")
          print("[Inside] Current user: \(authData.uid)")
          let btn = UIButton(type: .DetailDisclosure)
          //btn.setTitle("X", forState: Normal)
          annotationView?.rightCalloutAccessoryView = btn
        }
      }
    }
    else {
      annotationView?.annotation = annotation
    }
    
    return annotationView
  }
  
  func mapView(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments-12")
    
    let customAnnotation = annotationView.annotation as! MapAnnotation
    let momentId = customAnnotation.momentId!
    let momentPathRef = Firebase(url: "\(momentsRef)/\(momentId)")
    
    print("Moment ID: \(momentId)")
    print("Moment path ref: \(momentPathRef)")
    
    if control == annotationView.rightCalloutAccessoryView {
      momentPathRef.removeValue()
      mapView.removeAnnotation(customAnnotation)
    }
  }
}