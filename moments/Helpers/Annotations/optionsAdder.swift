import MapKit

class OptionsAdder {
  func run(options: MKMapSnapshotOptions, width: Int, height: Int, annotationView: MKAnnotationView) {
    options.size = CGSize(width: width, height: height)
    options.mapType = .SatelliteFlyover
    options.camera = MKMapCamera(lookingAtCenterCoordinate: annotationView.annotation!.coordinate, fromDistance: 250, pitch: 65, heading: 0)
  }
}