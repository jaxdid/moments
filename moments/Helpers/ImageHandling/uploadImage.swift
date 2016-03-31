import AWSS3

class UploadImage {
  func run(url: NSURL, uploadRequest: AWSS3TransferManagerUploadRequest) {
    uploadRequest.body = url
    uploadRequest.key = NSProcessInfo.processInfo().globallyUniqueString + ".jpg"
    uploadRequest.bucket = "makersmoments"
    uploadRequest.contentType = "image/"
    let transferManager = AWSS3TransferManager.defaultS3TransferManager()
    transferManager.upload(uploadRequest).continueWithBlock { (task) -> AnyObject! in
      UploadImageErrorHandler().run(task)
      UploadImageResultHandler().run(task, uploadRequest: uploadRequest)
      return nil
    }
  }
}
