class Formatter {
  func currentTime() -> String {
    let timestampFormatter = NSDateFormatter()
    timestampFormatter.dateStyle = .LongStyle
    timestampFormatter.timeStyle = .ShortStyle
    return timestampFormatter.stringFromDate(NSDate())
  }
}
