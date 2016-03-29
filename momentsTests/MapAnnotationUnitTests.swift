import XCTest
import CoreLocation

class MapAnnotationUnitTests: XCTestCase {
  
  let mapAnnotation = MapAnnotation(title: "Hello World",
                       subtitle: "test",
                       coordinate: CLLocationCoordinate2DMake(24, 16),
                       momoji: "momoji")
  
  func testMapAnnotationIsCreated() {
    XCTAssertNotNil(mapAnnotation)
  }
  
  func testMapAnnotationValues() {
    XCTAssertEqual(mapAnnotation.title, "Hello World")
  }
}
