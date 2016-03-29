import MapKit

class MapAnnotation: NSObject, MKAnnotation {
  let momentId: String?
  let title: String?
  let subtitle: String?
  let coordinate: CLLocationCoordinate2D
  let momoji: String!
  let timestamp: String?
  let uid: String?
  
  init(momentId: String, title: String, subtitle: String, coordinate: CLLocationCoordinate2D, momoji: String, timestamp: String, uid: String) {
    self.momentId = momentId
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    self.momoji = momoji
    self.timestamp = timestamp
    self.uid = uid
    super.init()
  }
}