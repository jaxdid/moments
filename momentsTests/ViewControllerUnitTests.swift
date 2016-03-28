import XCTest
import CoreLocation

@testable import moments

class ViewControllerUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValuePassedOnSegue() {
        let controller = ViewController()
        controller.userLocation = CLLocation(latitude: 12, longitude: 14)
        let destinationController = CreateMomentController()
        let segue = UIStoryboardSegue(identifier: "sa",
                                      source: controller,
                                      destination: destinationController)
        controller.prepareForSegue(segue, sender: nil)

        if let location:Optional = destinationController.userLocation {
            XCTAssertEqual(controller.userLocation, location)
        } else {
            XCTFail("Arguments should be passed")
        }
    }
}
