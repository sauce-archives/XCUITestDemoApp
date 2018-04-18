//
//  AddItemsTests.swift
//  ToDoSampleUITests
//
//  Created by David on 18.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import XCTest

class AddItemsTests: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["clear"]
        app.launch()
    }
    
}
