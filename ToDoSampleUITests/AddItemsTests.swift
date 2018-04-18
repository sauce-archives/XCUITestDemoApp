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

    func testExample() {
        let app = XCUIApplication()
        
        addListItem(title: "Foo")
        
        XCTAssertEqual(1, app.tables.staticTexts.matching(identifier: "Foo").count)
        
        app.cells.staticTexts["Foo"].tap()
        
        let greenButton = app.buttons["greenButton"]
        greenButton.waitForExistence(timeout: 10)
        greenButton.tap()
        app.navigationBars.buttons["Back"].tap()
        
        XCTAssert(app.cells.staticTexts["Foo"].isSelected)
        
        app.cells.containing(.staticText, identifier: "Foo").element.swipeLeft()
        
        deleteListItem(title: "Foo")
    }
    
    func testDrag() {
        addListItem(title: "Foo")
        addListItem(title: "Bar")
        
        let app = XCUIApplication()
        
        app.navigationBars.buttons["Edit"].tap()
        
        let foo = app.cells.buttons["Reorder Foo"]
        let bar = app.cells.buttons["Reorder Bar"]
        
        bar.press(forDuration: 0.5, thenDragTo: foo)
        
        app.navigationBars.buttons["Edit"].tap()
        
        XCTAssertEqual("Bar", app.cells.staticTexts.element(boundBy: 0).label)
        XCTAssertEqual("Foo", app.cells.staticTexts.element(boundBy: 1).label)
    }
    
    func testDetail() {
        addListItem(title: "Foo")
        
        app.cells.staticTexts["Foo"].tap()
        
        let exp = expectation(for: NSPredicate(format: "hittable = YES"), evaluatedWith: app.staticTexts["Title: Foo"], handler: nil)
        
        wait(for: [exp], timeout: 10)
    }
    
    func testSelectAny() {
        app.terminate()
        app.launchArguments = ["populate"]
        app.launch()


        
        app.tables.firstMatch.swipeUp()
        
        XCTAssertTrue(app.staticTexts["Item9"].isHittable)
    }
    
    func testSelectAny2() {
        app.terminate()
        app.launchArguments = ["populate"]
        app.launch()
        
        
        let table = app.tables.firstMatch
        
        let origin = table.coordinate(withNormalizedOffset: CGVector.zero)
        let center = origin.withOffset(CGVector(dx: 0, dy: table.frame.height/2))
        
        center.press(forDuration: 1, thenDragTo: origin)
    }
    
}
