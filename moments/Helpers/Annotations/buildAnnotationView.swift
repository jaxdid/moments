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
            default:
                annotationView?.image = UIImage(named:"grinning_face")
            }
            annotationView?.canShowCallout = true
            let momentsRef = Firebase(url: "https://makersmoments.firebaseio.com/moments")
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
        return annotationView
    }
}