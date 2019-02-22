//
//  MoviesDBTests.swift
//  MoviesDBTests
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import XCTest
@testable import MoviesDB

class MoviesDBTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchMoviesAreFetched() {
        //given
        let page = 1
        let urlString = "https://api.themoviedb.org/3/discover/movie"
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume().")
        let session = setupTestSessionAndProtocolMock(urlString: urlString, statusCode: 200)

        //when
        Movie.fetch(using: session, page: page, onSuccess: { (response) in
            XCTAssertEqual(response.page, page)
            XCTAssertEqual(response.movies[0].title, "Alita: Battle Angel")
            expectation.fulfill()
        })

        //then
        wait(for: [expectation], timeout: 5)
    }

    func testFetchMoviesReturnsErrorWhenResponseStatusNotEqual200() {
        //given
        let page = 1
        let urlString = "https://api.themoviedb.org/3/discover/movie"
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume().")
        let session = setupTestSessionAndProtocolMock(urlString: urlString, statusCode: 400)

        //when
        Movie.fetch(using: session, page: page, onSuccess: { (response) in
        }) { (error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        //then
        wait(for: [expectation], timeout: 5)
    }

    func setupTestSessionAndProtocolMock(urlString: String, statusCode: Int) -> URLSession {
        let testData = Data("{\"page\":1,\"total_results\":403387,\"total_pages\":20170,\"results\":[{\"vote_count\":606,\"id\":399579,\"video\":false,\"vote_average\":6.7,\"title\":\"Alita: Battle Angel\",\"popularity\":367.781,\"poster_path\":\"\\/xRWht48C2V8XNfzvPehyClOvDni.jpg\",\"original_language\":\"en\",\"original_title\":\"Alita: Battle Angel\",\"genre_ids\":[28,878,53],\"backdrop_path\":\"\\/aQXTw3wIWuFMy0beXRiZ1xVKtcf.jpg\",\"adult\":false,\"overview\":\"When Alita awakens with no memory of who she is in a future world she does not recognize, she is taken in by Ido, a compassionate doctor who realizes that somewhere in this abandoned cyborg shell is the heart and soul of a young woman with an extraordinary past.\",\"release_date\":\"2019-01-31\"}]}".utf8)
        URLProtocolMock.testData = testData
        URLProtocolMock.response = HTTPURLResponse(url: URL(string: urlString)!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
}

class URLProtocolMock: URLProtocol {
    static var testData: Data?
    static var url: URL?
    static var response: HTTPURLResponse?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request:
        URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        self.client?.urlProtocol(self, didLoad: URLProtocolMock.testData ?? Data())
        self.client?.urlProtocol(self, didReceive: URLProtocolMock.response ?? URLResponse(), cacheStoragePolicy: URLCache.StoragePolicy.notAllowed)
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}

