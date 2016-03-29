import MapKit

class MapAnnotation: NSObject, MKAnnotation {
  let title: String?
  let subtitle: String?
  let coordinate: CLLocationCoordinate2D
  let momoji: String!
  
  init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, momoji: String) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    self.momoji = momoji
    
    super.init()
  }
}

