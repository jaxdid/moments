//
//  ViewControllerUnitTests.swift
//  moments
//
//  Created by Tom Pickard on 26/03/2016.
//  Copyright © 2016 moments. All rights reserved.
//

import XCTest
@testable import moments

class ViewControllerUnitTests: XCTestCase {
    
    var viewController : ViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        viewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
        
        let _ = viewController.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValuePassedOnSegue() {
        let controller = ViewController()
        controller.latitude = 37.89
        let destinationController = CreateMomentController()
        let segue = UIStoryboardSegue(identifier: "sa",
                                      source: controller,
                                      destination: destinationController)
        controller.prepareForSegue(segue, sender: nil)
        
        if let latitude = controller.latitude {
            XCTAssertEqual(37.89, latitude)
        } else {
            XCTFail("Arguments should be passed")
        }
    }
}
