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
    
    func testExample() {
        
        let app = XCUIApplication()
        let moviesDbNavigationBar = app.navigationBars["Movies DB"]
        moviesDbNavigationBar.buttons["Add"].tap()
        
        let addMovieNavigationBar = app.navigationBars["Add Movie"]
        addMovieNavigationBar.otherElements["Add Movie"].tap()
        addMovieNavigationBar.buttons["Movies DB"].tap()
        moviesDbNavigationBar.otherElements["Movies DB"].tap()
        
//        let tablesQuery = app.tables.cells.allElemen
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Alita: Battle Angel"]/*[[".cells.staticTexts[\"Alita: Battle Angel\"]",".staticTexts[\"Alita: Battle Angel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["2019-01-31"]/*[[".cells.staticTexts[\"2019-01-31\"]",".staticTexts[\"2019-01-31\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        app.navigationBars["Movies DB"].buttons["Add"].tap()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.textFields["dateTextField"]/*[[".textFields[\"5\/9\/1993\"]",".textFields[\"dateTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.datePickers.pickerWheels["27"].swipeUp()
        
        //XCUIApplication().tables.staticTexts["All Movies"].tap()
        
    }
    
    func testSaveButtonAddsMovieToTableviewFirstCell() {
        let app = XCUIApplication()
        app.buttons["Add"].tap()
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("title test")
        
        let overviewTextView = app.textViews["overviewTextView"]
        overviewTextView.tap()
        app.keys["T"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app.keyboards.buttons["Return"].tap()
    }
    
    func testTableViewExists() {
        let app = XCUIApplication()
        XCTAssertNotNil(app.tables.element)
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
}
