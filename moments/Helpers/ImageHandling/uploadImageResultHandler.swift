import AWSS3

class UploadImageResultHandler {
    func run(task: AWSTask, uploadRequest: AWSS3TransferManagerUploadRequest) {
        if task.result != nil {
            let s3URL = NSURL(string: "http://s3.amazonaws.com/makersmoments/\(uploadRequest.key!)")!
            print("Uploaded to:\n\(s3URL)")
        }
        else {
            print("Unexpected empty result.")
        }
    }
}