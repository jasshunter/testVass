//
//  APIServiceTests.swift
//  MovieListTests
//
//  Created by JASS on 26/05/24.
//

import XCTest
import Alamofire
@testable import MovieList

final class APIServiceTests: XCTestCase {
    
    var session: Session!
    var apiService: APIService!
    
    let jsonString = """
        {
            "page": 1,
            "results": [
                {
                    "adult": false,
                    "backdrop_path": "/path.jpg",
                    "genre_ids": [12, 28],
                    "id": 123,
                    "original_language": "en",
                    "original_title": "Movie Title",
                    "overview": "Overview of the movie",
                    "popularity": 100.0,
                    "poster_path": "/poster.jpg",
                    "release_date": "2023-01-01",
                    "title": "Movie Title",
                    "video": false,
                    "vote_average": 8.5,
                    "vote_count": 1000
                }
            ],
            "total_pages": 10,
            "total_results": 100
        }
        """
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        session = Session(configuration: configuration)
        apiService = APIService(session: session)
    }
    
    override func tearDown() {
        session = nil
        apiService = nil
        super.tearDown()
    }
    
    func testGetPopularMoviesSuccess() {
        let expectation = self.expectation(description: "Success callback is called")
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = self.jsonString.data(using: .utf8)
            return (response, data)
        }
        
        apiService.getPopularMovies(successCallback: { response in
            XCTAssertEqual(response.page, 1)
            XCTAssertEqual(response.results?.first?.title, "Movie Title")
            expectation.fulfill()
        }, errorCallback: { _ in
            XCTFail("Error callback should not be called")
        }, networkErrorCallback: { _ in
            XCTFail("Network error callback should not be called")
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetPopularMoviesAPIError() {
        let expectation = self.expectation(description: "Error callback is called")
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = "{\"error\":\"something went wrong\"}".data(using: .utf8)
            return (response, data)
        }
        
        apiService.getPopularMovies(successCallback: { _ in
            XCTFail("Success callback should not be called")
        }, errorCallback: { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }, networkErrorCallback: { _ in
            XCTFail("Network error callback should not be called")
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetPopularMoviesNetworkError() {
        let expectation = self.expectation(description: "Network error callback is called")
        
        MockURLProtocol.requestHandler = { request in
            throw NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil)
        }
        
        apiService.getPopularMovies(successCallback: { _ in
            XCTFail("Success callback should not be called")
        }, errorCallback: { _ in
            XCTFail("Error callback should not be called")
        }, networkErrorCallback: { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }    
    
    func testGetTopRatedMoviesSuccess() {
        let expectation = self.expectation(description: "Success callback is called")
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = self.jsonString.data(using: .utf8)
            return (response, data)
        }
        
        apiService.getTopRatedMovies(successCallback: { response in
            XCTAssertEqual(response.page, 1)
            XCTAssertEqual(response.results?.first?.title, "Movie Title")
            expectation.fulfill()
        }, errorCallback: { _ in
            XCTFail("Error callback should not be called")
        }, networkErrorCallback: { _ in
            XCTFail("Network error callback should not be called")
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetTopRatedMoviesAPIError() {
        let expectation = self.expectation(description: "Error callback is called")
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = "{\"error\":\"something went wrong\"}".data(using: .utf8)
            return (response, data)
        }
        
        apiService.getTopRatedMovies(successCallback: { _ in
            XCTFail("Success callback should not be called")
        }, errorCallback: { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }, networkErrorCallback: { _ in
            XCTFail("Network error callback should not be called")
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetTopRatedMoviesNetworkError() {
        let expectation = self.expectation(description: "Network error callback is called")
        
        MockURLProtocol.requestHandler = { request in
            throw NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil)
        }
        
        apiService.getTopRatedMovies(successCallback: { _ in
            XCTFail("Success callback should not be called")
        }, errorCallback: { _ in
            XCTFail("Error callback should not be called")
        }, networkErrorCallback: { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
