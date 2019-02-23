//
//  MoviesDatasourceTests.swift
//  MoviesDBTests
//
//  Created by Mahmoud Abolfotoh on 2/23/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import XCTest
@testable import MoviesDB

class MoviesControllerTests: XCTestCase {
    var movies = [Movie]()

    override func setUp() {
        for i in 0...4 {
            movies.append(Movie(title: "title\(i)", overview: "overview\(i)", date: "10-\(i)-2019", posterURL: "poster url \(i)"))
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigationBarHasAllMoviesTitle() {
        //given
        let moviesController = MoviesController()

        //when
        moviesController.loadViewIfNeeded()

        //then
        XCTAssertEqual(moviesController.title, "All Movies")
    }

    func testTableViewExists() {
        //given
        let moviesController = MoviesController()

        //when
        moviesController.loadViewIfNeeded()

        //then
        XCTAssertNotNil(moviesController.tableView)
    }

    func testTableViewRowCountEqualMoviesCount() {
        //given
        let datasource = MoviesTableViewDataSource(isTesting: true)
        datasource.movies = movies
        let moviesController = MoviesController()
        moviesController.dataSource = datasource

        //when
        moviesController.loadViewIfNeeded()

        //then
        let rowCount = moviesController.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(movies.count, rowCount)
    }

    func testTableViewCellTitleLabelHasCorrectText() {
        //given
        let datasource = MoviesTableViewDataSource(isTesting: true)
        datasource.movies = movies
        let moviesController = MoviesController()
        moviesController.dataSource = datasource

        //when
        moviesController.loadViewIfNeeded()

        //then
        for (index, movie) in movies.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = datasource.tableView(moviesController.tableView, cellForRowAt: indexPath)
            XCTAssertEqual(cell.textLabel?.text, movie.title)
        }
    }
}
