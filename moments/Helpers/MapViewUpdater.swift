import MapKit
import CoreLocation

class MapViewUpdater {
  func run(map: MKMapView, userCoordinate: CLLocationCoordinate2D) {
    let viewRadius: CLLocationDegrees = 0.001
    let region = MKCoordinateRegionMake(userCoordinate, MKCoordinateSpanMake(viewRadius, viewRadius))
    map.setRegion(region, animated: true)
  }
}