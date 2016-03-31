import AWSS3

extension CreateMomentController {
  func uploadImage(url: NSURL) {
    uploadRequest.body = url
    uploadRequest.key = NSProcessInfo.processInfo().globallyUniqueString + ".jpg"
    uploadRequest.bucket = self.s3bucket
    uploadRequest.contentType = "image/"
    let transferManager = AWSS3TransferManager.defaultS3TransferManager()
    transferManager.upload(uploadRequest).continueWithBlock { (task) -> AnyObject! in
      if let error = task.error {
        print("Upload failed (\(error))")
      }
      if let exception = task.exception {
        print("Upload failed (\(exception))")
      }
      if task.result != nil {
        let s3URL = NSURL(string: "http://s3.amazonaws.com/\(self.s3bucket)/\(self.uploadRequest.key!)")!
        print("Uploaded to:\n\(s3URL)")
      }
      else {
        print("Unexpected empty result.")
      }
      return nil
    }
  }
}
