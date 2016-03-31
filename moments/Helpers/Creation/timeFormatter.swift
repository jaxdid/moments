class Formatter {
  func currentTime() -> String {
    let timestampFormatter = NSDateFormatter()
    timestampFormatter.dateStyle = .LongStyle
    timestampFormatter.timeStyle = .MediumStyle
    return timestampFormatter.stringFromDate(NSDate())
  }
}
