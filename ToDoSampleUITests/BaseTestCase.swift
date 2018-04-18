//
//  BaseTestCase.swift
//  ToDoSampleUITests
//
//  Created by David on 18.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import XCTest

class BaseTestCase: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launchArguments = ["clear"]
        
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
