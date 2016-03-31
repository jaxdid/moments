import XCTest

class momentUnitTests: XCTestCase {

  let moment = Moment()
  
  func testBuildMethod() {
    var testBuild = moment.build("selectedMomoji",
                 text: "textField.text!",
                 latitude: 10,
                 longitude: 10,
                 userName: "self.userName",
                 uid: "self.uid",
                 timestamp: "formatTime.stringFromDate(NSDate())",
                 imageKey: "imageKey")
    let testBuildvar = testBuild["text"] as? String
    XCTAssertEqual(testBuildvar, "textField.text!")
  }
}
