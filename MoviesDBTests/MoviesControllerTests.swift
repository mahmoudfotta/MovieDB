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
    var moviesResponse: MoviesResponse?

    override func setUp() {
        for i in 0...4 {
            movies.append(Movie(title: "title\(i)", overview: "overview\(i)", date: "10-\(i)-2019", posterURL: "poster url \(i)"))
        }

        moviesResponse = MoviesResponse(page: 1, totalPages: 100, movies: movies)
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
        XCTAssertEqual(moviesController.title, "Movies DB")
    }

    func testTableViewExists() {
        //given
        let moviesController = MoviesController()

        //when
        moviesController.loadViewIfNeeded()

        //then
        XCTAssertNotNil(moviesController.tableView)
    }

    func testHandleResponseIncreasesMoviesCountByResponsMoviesCount() {
        //given
        let dataSource = MoviesTableViewDataSource()
        dataSource.movies = movies

        //when
        dataSource.handleResponse(response: moviesResponse!)
        let moviesCount = dataSource.movies.count

        //then
        XCTAssertEqual(moviesCount, movies.count + (moviesResponse?.movies.count ?? 0))
    }

    func testHandleResponseIncrementsPageCountByOne() {
        //given
        let dataSource = MoviesTableViewDataSource()
        let beforePage = dataSource.page

        //when
        dataSource.handleResponse(response: moviesResponse!)
        let afterPage = dataSource.page

        //then
        XCTAssertEqual(afterPage, beforePage + 1)
    }

    func testHandleResponseCallsDataChangedClosure() {
        //given
        let dataSource = MoviesTableViewDataSource()
        let expectation = XCTestExpectation(description: "Data changed gets called.")

        //when
        dataSource.handleResponse(response: moviesResponse!)
        dataSource.dataChanged = { (success) in
            expectation.fulfill()
        }

        //then
        wait(for: [expectation], timeout: 2)

    }

    func testIsLastCellInTableviewWithLastIndexPathReturnsTrue() {
        //given
        let datasource = MoviesTableViewDataSource(isTesting: true)
        datasource.movies = movies
        let moviesController = MoviesController()
        moviesController.dataSource = datasource

        //when
        moviesController.loadViewIfNeeded()
        let result = moviesController.tableView.isLast(IndexPath(row: datasource.movies.count - 1, section: 0))

        //then
        XCTAssertTrue(result)
    }

    func testShouldRequestMoreMoviesWhenPageGreaterThanOrEqualTotalPagesReturnsFalse() {
        //given
        let page = 100
        let totalPages = 100

        //when
        guard let result = moviesResponse?.shouldRequestMoreMovies(at: page, totalPages: totalPages) else { return }

        //then
        XCTAssertFalse(result)
    }

    func testShouldRequestMoreMoviesWhenPageLessThanTotalPagesReturnsTrue() {
        //given
        let page = 99
        let totalPages = 100

        //when
        guard let result = moviesResponse?.shouldRequestMoreMovies(at: page, totalPages: totalPages) else { return }

        //then
        XCTAssertTrue(result)
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
            guard let cell = datasource.tableView(moviesController.tableView, cellForRowAt: indexPath) as? MovieTableViewCell else { return }
            XCTAssertEqual(cell.titleLabel.text, movie.title)
        }
    }
    
    func testTableViewCellOverviewLabelHasCorrectText() {
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
            guard let cell = datasource.tableView(moviesController.tableView, cellForRowAt: indexPath) as? MovieTableViewCell else { return }
            XCTAssertEqual(cell.overviewLabel.text, movie.overview)
        }
    }
    
    func testTableViewCellDateLabelHasCorrectText() {
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
            guard let cell = datasource.tableView(moviesController.tableView, cellForRowAt: indexPath) as? MovieTableViewCell else { return }
            XCTAssertEqual(cell.dateLabel.text, movie.date)
        }
    }
}
