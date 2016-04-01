extension CreateMomentController {
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 16
  }
  
  func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 40
  }
  
  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    
    let pickerViewSelection = PickerViewSelectionParser().run(row)
    selectedMomoji = pickerViewSelection.selectedMomoji
    return pickerViewSelection.imageView
  }
}