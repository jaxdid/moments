import AWSS3

class ImageKeyValidator {
  func run(uploadRequest: AWSS3TransferManagerUploadRequest) -> String {
    var imageKey = "no image"
    
    if uploadRequest.key != nil {
      imageKey = uploadRequest.key!
    }
    return imageKey
  }
}