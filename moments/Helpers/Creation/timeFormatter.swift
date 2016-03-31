class Formatter {
  func formatTime() -> NSDateFormatter {
    let timestampFormatter = NSDateFormatter()
    timestampFormatter.dateStyle = .LongStyle
    timestampFormatter.timeStyle = .MediumStyle
    return timestampFormatter
  }
}
