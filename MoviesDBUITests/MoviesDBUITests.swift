//
//  MoviesDBUITests.swift
//  MoviesDBUITests
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import XCTest

class MoviesDBUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTableViewCellsEqualOne() {
        let app = XCUIApplication()
        let table = app.tables.element
        let cellsCount = table.cells.count
        
        XCTAssertEqual(cellsCount, 1)
    }
    
    func testFirstCellTitleLableExists() {
        let app = XCUIApplication()
        let table = app.tables.element
        let cell = table.cells.element
        
        XCTAssert(cell.staticTexts["title test"].exists)
    }
    
    func testFirstCellOverviewLableExists() {
        let app = XCUIApplication()
        let table = app.tables.element
        let cell = table.cells.element
        
        XCTAssert(cell.staticTexts["overview test"].exists)
    }
    
    func testFirstCellDateLableExists() {
        let app = XCUIApplication()
        let table = app.tables.element
        let cell = table.cells.element
        
        XCTAssert(cell.staticTexts["5-9-1993"].exists)
    }
    
    func testTabBarAddButtonOpensAddMovieController() {
        let app = XCUIApplication()
        app.buttons["Add"].tap()
        XCTAssert(app.navigationBars["Add Movie"].exists)
    }
    
    func testAddMovieViewUIElementsExists() {
        let app = XCUIApplication()
        app.buttons["Add"].tap()
        XCTAssert(app.staticTexts["titleLabel"].exists)
        XCTAssert(app.textFields["titleTextField"].exists)
        XCTAssert(app.staticTexts["overviewLabel"].exists)
        XCTAssert(app.textViews["overviewTextView"].exists)
        XCTAssert(app.staticTexts["dateLabel"].exists)
        XCTAssert(app.textFields["dateTextField"].exists)
    }
    
    func testSaveButtonAddsMovieToTableviewFirstCell() {
        let app = XCUIApplication()
        app.buttons["Add"].tap()
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("title test")
        
        let overviewTextView = app.textViews["overviewTextView"]
        overviewTextView.tap()
        overviewTextView.typeText("test overview")
        
        let dateTextField = app.textFields["dateTextField"]
        dateTextField.tap()
        dateTextField.typeText("4/4/2020")
    
        app.buttons["Save"].tap()
        
        let table = app.tables.element
        let cell = table.cells.element
        
        XCTAssert(cell.staticTexts["title test"].exists)
    }
}
