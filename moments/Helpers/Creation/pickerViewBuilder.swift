extension CreateMomentController {
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 2
  }
  
  func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 40
  }
  
  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    
    //==================================
    //var myImageView = UIImageView()
    
//    switch row {
//    case 0:
//      myImageView = UIImageView(image: UIImage(named:"grinning_face"))
//      selectedMomoji = "1F600"
//    case 1:
//      myImageView = UIImageView(image: UIImage(named:"joy"))
//      selectedMomoji = "1F602"
//    default:
//      myImageView.image = nil
//    }
    //==================================
    
    let pickerViewSelection = PickerViewSelectionParser().run(row)
    selectedMomoji = pickerViewSelection.selectedMomoji
    return pickerViewSelection.imageView
  }
}