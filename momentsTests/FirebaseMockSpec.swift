import XCTest
import Quick
import Nimble

class FirebaseMockSpec: QuickSpec {
    override func spec() {
        var ref: MockFirebase!
        
        describe("creating moments") {
            
            beforeEach {
                ref = MockFirebase()
            }
            
            it("lets you create a moment"){
                
                ref.createMoment("hello")
                
                expect(ref.moment.text).to(equal("hello"))
            }
        }
        
        describe("retrieving moments from database") {
            var data: NSDictionary?
            var snapshot: Snapshot!
            beforeEach {
                ref = MockFirebase()
                data = [
                    "moments" : [
                        "moment1": [
                            "text": "hello"]]]
                
                snapshot = Snapshot(FBref: ref, data: data!)!
            }
            it("has child moments"){
                expect(snapshot.hasChild("moments")).to(equal(true))
            }
            
            it("it only has one child"){
                expect(snapshot.childrenCount).to(equal(1))
                }
            
            it("get data from objects in the database") {
                
                let moment = snapshot.childSnapshotForPath("moments")
                expect(moment.childSnapshotForPath("moment1").value["text"]).to(equal("hello"))
            }
            
        
        }
    }
}

