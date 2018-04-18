//
//  Actions.swift
//  ToDoSampleUITests
//
//  Created by David on 18.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import XCTest

func deleteListItem(title: String) {
    let app = XCUIApplication()
    
    let row = app.cells.containing(.staticText, identifier: title).element
    
    row.swipeLeft()
    row.buttons["Delete"].tap()
}

func moveListItemToTop(title: String) {
    let app = XCUIApplication()
    
    let row = app.cells.containing(.staticText, identifier: title).element
    
    row.swipeLeft()
    row.buttons["Move to top"].tap()
}

func addListItem(title: String) {
    let app = XCUIApplication()
    app.buttons["Add"].tap()
    app.textFields["Title"].typeText(title)
    app.alerts.buttons["Add"].tap()
}
