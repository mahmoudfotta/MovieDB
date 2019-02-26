//
//  AddMovieControllerTests.swift
//  MoviesDBTests
//
//  Created by Mahmoud Abolfotoh on 2/26/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import XCTest
@testable import MoviesDB

class AddMovieControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddMovieReturnsCorrectMovieData() {
        //given
        let addMovieController = AddMovieController()
        let delegate = AddMovieControllerDelegateHandler()
        addMovieController.delegate = delegate
        let title = "test title"
        let date = "test date"
        let overview = "test overview"
        let expectation = XCTestExpectation(description: "test add Movie delegate.")
        
        //when
        addMovieController.loadViewIfNeeded()
        delegate.addMovieAction = { movie in
            XCTAssertEqual(movie.title, title)
            expectation.fulfill()
        }
        addMovieController.addMovie(with: title, date: date, overview: overview)

        //then
        wait(for: [expectation], timeout: 5)
    }
}
