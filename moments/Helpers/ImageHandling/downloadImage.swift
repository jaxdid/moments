import AWSS3

extension MapController {
  
  func downloadImage(imageKey: String) {
    let downloadingFilePath1 = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("temp-image")
    let downloadingFileURL1 = NSURL(fileURLWithPath: downloadingFilePath1 )
    let transferManager = AWSS3TransferManager.defaultS3TransferManager()
    
    let readRequest1 : AWSS3TransferManagerDownloadRequest = AWSS3TransferManagerDownloadRequest()
    readRequest1.bucket = "makersmoments"
    readRequest1.key = imageKey
    readRequest1.downloadingFileURL = downloadingFileURL1
    
    let task = transferManager.download(readRequest1)
    task.continueWithBlock { (task) -> AnyObject! in
      if task.error != nil {
      } else {
        let code = dispatch_async(dispatch_get_main_queue()
          , { () -> Void in
            self.image = UIImage(contentsOfFile: downloadingFilePath1)
        })
      }
      return nil
    }
  }
}
