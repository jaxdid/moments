//
//  CreateMomentUnitTests.swift
//  moments
//
//  Created by Tom Pickard on 26/03/2016.
//  Copyright © 2016 moments. All rights reserved.
//

import XCTest
@testable import moments

class CreateMomentUnitTests: XCTestCase {
    
    var createMomentController : CreateMomentController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        createMomentController = storyboard.instantiateViewControllerWithIdentifier("CreateMomentController") as! CreateMomentController
        UIApplication.sharedApplication().keyWindow!.rootViewController = createMomentController
        
        let _ = createMomentController
    }
    
    override func tearDown() {
        super.tearDown()
    }


}
