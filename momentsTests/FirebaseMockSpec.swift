//
//  FirebaseMockSpec.swift
//  moments
//
//  Created by Reiss Johnson on 28/03/2016.
//  Copyright © 2016 moments. All rights reserved.
//

import XCTest
import Quick
import Nimble

class FirebaseMockSpec: QuickSpec {
    
    override func spec() {
        var ref: MockFirebase!
        UIApplication.sharedApplication().delegate = TestingAppDelegate()
        
        describe("moments") {
        
            beforeEach {
            ref = MockFirebase()
            }
        
            it("lets you create a moment"){
                ref.setValue(["text": "mockstring"])
                ref.observeEventType(.ChildAdded, withBlock: { snapshot
                    in
                    print (snapshot.value.objectForKey("text"))
                    //expect(snapshot.value.objectForKey("text")).to(equal("mockstring"))
                })
            }
        }
    }
}
