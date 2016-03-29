import UIKit
import MapKit

extension MapController {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
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
        }
        else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}