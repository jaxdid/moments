import Firebase
import MapKit

class AnnotationBuilder {
  func run(snapshot: FDataSnapshot) -> MapAnnotation {
    let latitude = snapshot.value.objectForKey("latitude") as! Double
    let longitude = snapshot.value.objectForKey("longitude") as! Double
    let text = snapshot.value.objectForKey("text") as! String
    let momoji = snapshot.value.objectForKey("momoji") as! String
    let momentId = snapshot.key
    let timestamp = snapshot.value.objectForKey("timestamp") as! String
    let uid = snapshot.value.objectForKey("userId") as! String
    let userName = snapshot.value.objectForKey("userName") as! String
    let imageKey = snapshot.value.objectForKey("imageKey") as! String
  
    return MapAnnotation(momentId: momentId,
                         title: "\(text)",
                         subtitle: "\(timestamp) by \(userName)",
                         coordinate: CLLocationCoordinate2DMake(latitude, longitude),
                         momoji: momoji,
                         timestamp: timestamp,
                         uid: uid,
                         imageKey: imageKey)
  }
}