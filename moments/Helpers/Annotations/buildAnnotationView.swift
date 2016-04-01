import MapKit
import Firebase

class BuildAnnotationView {
  func run(mapView: MKMapView, reuseId: String, annotation: MKAnnotation, customAnnotation: MapAnnotation) -> MKAnnotationView? {
    var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
    if annotationView == nil {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      switch customAnnotation.momoji {
      case "1F600":
        annotationView?.image = UIImage(named:"grinning_face")
      case "1F602":
        annotationView?.image = UIImage(named:"joy")
      case "1F369":
        annotationView?.image = UIImage(named:"1F369")
      case "1F1F7":
        annotationView?.image = UIImage(named:"1F1F7")
      case "1F3D6":
        annotationView?.image = UIImage(named:"1F3D6")
      case "1F5FB":
        annotationView?.image = UIImage(named:"1F5FB")
      case "1F6C0":
        annotationView?.image = UIImage(named:"1F6C0")
      case "1F37B":
        annotationView?.image = UIImage(named:"1F37B")
      case "1F37E":
        annotationView?.image = UIImage(named:"1F37E")
      case "1F60D":
        annotationView?.image = UIImage(named:"1F60D")
      case "1F60E":
        annotationView?.image = UIImage(named:"1F60E")
      case "1F305":
        annotationView?.image = UIImage(named:"1F305")
      case "1F393":
        annotationView?.image = UIImage(named:"1F393")
      case "1F492":
        annotationView?.image = UIImage(named:"1F492")
      case "1F918":
        annotationView?.image = UIImage(named:"1F918")
      case "2603":
        annotationView?.image = UIImage(named:"2603")
      default:
        annotationView?.image = UIImage()
      }
      annotationView?.canShowCallout = true
      
      if customAnnotation.uid == NSUserDefaults.standardUserDefaults().objectForKey("currentUser")?["uid"] {
        let deleteButton = UIButton(type: .InfoDark)
        deleteButton.setImage(UIImage(named:"delete") as UIImage?, forState: UIControlState.Normal)
        annotationView?.rightCalloutAccessoryView = deleteButton
      }
    }
    else {
      annotationView?.annotation = annotation
    }
    return annotationView
  }
}