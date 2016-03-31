class UploadImageErrorHandler {
  func run(task: AWSTask) {
    if let error = task.error {
      print("Upload failed (\(error))")
    }
    
    if let exception = task.exception {
      print("Upload failed (\(exception))")
    }
  }
}