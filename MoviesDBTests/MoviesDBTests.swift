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
        let testData = Data("{\"page\":1,\"total_results\":403387,\"total_pages\":20170,\"results\":[{\"title\":\"Alita: Battle Angel\",\"poster_path\":\"\\/xRWht48C2V8XNfzvPehyClOvDni.jpg\",\"original_language\":\"en\",\"genre_ids\":[28,878,53],\"overview\":\"When Alita awakens with no memory of who she is in a future world\",\"release_date\":\"2019-01-31\"}]}".utf8)
        let page = 1
        let urlString = EndPoint.movies.description
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume().")
        let session = setupTestSessionAndProtocolMock(testData: testData, urlString: urlString, statusCode: 200)

        //when
        let moviesResponse = MoviesResponse()
        moviesResponse.fetch(using: session, page: page, onSuccess: { (response) in
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
        let urlString = EndPoint.movies.description
        let expectation = XCTestExpectation(description: "Downloading news stories triggers resume().")
        let session = setupTestSessionAndProtocolMock(testData: Data(), urlString: urlString, statusCode: 400)

        //when
        let moviesResponse = MoviesResponse()
        moviesResponse.fetch(using: session, page: page, onSuccess: { (response) in
        }) { (error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        //then
        wait(for: [expectation], timeout: 5)
    }
    
    func testCacheImageEqualsNotAvailableImage() {
        //given
        let imageView = UIImageView()
        let imageCache = NSCache<AnyObject, AnyObject>()
        let expectation = XCTestExpectation(description: "Downloading Image and cache it.")
        let urlString = EndPoint.image(path: "wrongpath").description
        let session = setupTestSessionAndProtocolMock(testData: Data(), urlString: urlString, statusCode: 404)

        //when
        imageView.cacheImage(with: urlString, and: session, into: imageCache) {
            let image = imageCache.object(forKey: urlString as AnyObject)
            XCTAssertEqual(imageView.image, image as? UIImage)
            expectation.fulfill()
        }

        //then
        wait(for: [expectation], timeout: 5)
    }

    func testCacheImageEqualsImageViewImage() {
        //given
        let testData = #imageLiteral(resourceName: "testImage").pngData()
        let imageView = UIImageView()
        let imageCache = NSCache<AnyObject, AnyObject>()
        let expectation = XCTestExpectation(description: "Downloading Image and cache it.")
        let urlString = EndPoint.image(path: "nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg").description
        let session = setupTestSessionAndProtocolMock(testData: testData!, urlString: urlString, statusCode: 200)

        //when
        imageView.cacheImage(with: urlString, and: session, into: imageCache) {
            let image = imageCache.object(forKey: urlString as AnyObject)
            XCTAssertEqual(imageView.image, image as? UIImage)
            expectation.fulfill()
        }

        //then
        wait(for: [expectation], timeout: 5)
    }

    func setupTestSessionAndProtocolMock(testData: Data, urlString: String, statusCode: Int) -> URLSession {
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
