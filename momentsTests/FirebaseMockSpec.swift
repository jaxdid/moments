import XCTest
import Quick
import Nimble

class FirebaseMockSpec: QuickSpec {
    override func spec() {
        var ref: MockFirebase!
        
        describe("moments") {
            
            beforeEach {
                ref = MockFirebase()
            }
            
            it("lets you create a moment"){
                
                ref.createMoment("hello")
                
                expect(ref.moment.text).to(equal("hello"))
            }
        }
        
    }
}

