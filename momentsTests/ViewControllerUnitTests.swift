import XCTest
import CoreLocation

@testable import moments

class ViewControllerUnitTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        viewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        
        let _ = viewController
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValuePassedOnSegue() {
        viewController.userLocation = CLLocation(latitude: 12, longitude: 14)
        let destinationController = CreateMomentController()
        let segue = UIStoryboardSegue(identifier: "Location",
                                      source: viewController,
                                      destination: destinationController)
        viewController.prepareForSegue(segue, sender: nil)

        if let location:Optional = destinationController.userLocation {
            XCTAssertEqual(viewController.userLocation, location)
        } else {
            XCTFail("Arguments should be passed")
        }
    }
    

}
