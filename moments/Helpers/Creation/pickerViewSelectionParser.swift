class PickerViewSelectionParser {
  func run(row: Int) -> (imageView: UIImageView, selectedMomoji: String) {
    switch row {
    case 0:
      return (UIImageView(image: UIImage(named:"grinning_face")), "1F600")
    case 1:
      return (UIImageView(image: UIImage(named:"joy")), "1F602")
    case 2:
      return (UIImageView(image: UIImage(named:"1F369")), "1F369")
    case 3:
      return (UIImageView(image: UIImage(named:"1F1F7")), "1F1F7")
    case 4:
      return (UIImageView(image: UIImage(named:"1F3D6")), "1F3D6")
    case 5:
      return (UIImageView(image: UIImage(named:"1F5FB")), "1F5FB")
    case 6:
      return (UIImageView(image: UIImage(named:"1F6C0")), "1F6C0")
    case 7:
      return (UIImageView(image: UIImage(named:"1F37B")), "1F37B")
    case 8:
      return (UIImageView(image: UIImage(named:"1F37E")), "1F37E")
    case 9:
      return (UIImageView(image: UIImage(named:"1F60D")), "1F60D")
    case 10:
      return (UIImageView(image: UIImage(named:"1F60E")), "1F60E")
    case 11:
      return (UIImageView(image: UIImage(named:"1F305")), "1F305")
    case 12:
      return (UIImageView(image: UIImage(named:"1F393")), "1F393")
    case 13:
      return (UIImageView(image: UIImage(named:"1F492")), "1F492")
    case 14:
      return (UIImageView(image: UIImage(named:"1F918")), "1F918")
    case 15:
      return (UIImageView(image: UIImage(named:"2603")), "2603")
    default:
      return (UIImageView(), "")
    }
  }
}