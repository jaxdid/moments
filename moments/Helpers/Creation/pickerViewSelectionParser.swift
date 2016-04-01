class PickerViewSelectionParser {
  func run(row: Int) -> (imageView: UIImageView, selectedMomoji: String) {
    switch row {
    case 0:
      return (UIImageView(image: UIImage(named:"grinning_face")), "1F600")
    case 1:
      return (UIImageView(image: UIImage(named:"joy")), "1F602")
    default:
      return (UIImageView(), "")
    }
  }
}