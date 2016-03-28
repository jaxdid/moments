import XCTest
import CoreLocation

@testable import moments

class MapControllerUnitTests: XCTestCase {
    
    var mapController: MapController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        mapController = storyboard.instantiateViewControllerWithIdentifier("MapController") as! MapController
        UIApplication.sharedApplication().keyWindow!.rootViewController = mapController
        
        let _ = mapController
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValuePassedOnSegue() {
        mapController.userCoordinate = CLLocationCoordinate2D(latitude: 12, longitude: 14)
        let destinationController = CreateMomentController()
        let segue = UIStoryboardSegue(identifier: "Location",
                                      source: mapController,
                                      destination: destinationController)
        mapController.prepareForSegue(segue, sender: nil)

      if let latitude: Optional = destinationController.userCoordinate.latitude {
            XCTAssertEqual(mapController.userCoordinate.latitude, latitude)
        } else {
            XCTFail("Arguments should be passed")
        }
    }
    

}
