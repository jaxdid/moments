import MapKit

class ImageProcessor {
  func run(snapshot: MKMapSnapshot!, width: Int, height: Int, image: UIImage, snapshotView: UIView) {
    if snapshot != nil {
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
      imageView.image = image
      snapshotView.addSubview(imageView)
    }
  }
}