import XCTest
import CoreLocation

class MapAnnotationUnitTests: XCTestCase {
  
  let mapAnnotation = MapAnnotation(momentId: "moment",
                                    title: "Hello World",
                                    subtitle: "test",
                                    coordinate: CLLocationCoordinate2DMake(24, 16),
                                    momoji: "momoji",
                                    timestamp: "29-mar-16",
                                    uid: "fb-123",
                                    imageKey: "key")
  
  func testMapAnnotationIsCreated() {
    XCTAssertNotNil(mapAnnotation)
  }
  
  func testMapAnnotationValues() {
    XCTAssertEqual(mapAnnotation.title, "Hello World")
  }
}
