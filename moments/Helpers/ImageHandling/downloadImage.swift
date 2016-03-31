import AWSS3

extension MapController {
  func downloadImage(imageKey: String) {
    let downloadingFilePath = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("temp-image")
    let downloadingFileURL = NSURL(fileURLWithPath: downloadingFilePath )
    let transferManager = AWSS3TransferManager.defaultS3TransferManager()
    
    let readRequest : AWSS3TransferManagerDownloadRequest = AWSS3TransferManagerDownloadRequest()
    readRequest.bucket = "makersmoments"
    readRequest.key = imageKey
    readRequest.downloadingFileURL = downloadingFileURL
    
    let task = transferManager.download(readRequest)
    task.continueWithBlock { (task) -> AnyObject! in
      if task.error != nil {
      } else {
        let code = dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.image = UIImage(contentsOfFile: downloadingFilePath)
        })
      }
      return nil
    }
  }
}
