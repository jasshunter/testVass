//
//  NetworkManagerTests.swift
//  MovieListTests
//
//  Created by JASS on 25/05/24.
//

import XCTest
@testable import MovieList
import Alamofire

class NetworkManagerTests: XCTestCase {
    
    var session: Session!
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        session = Session(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        super.tearDown()
    }
    
    func testBasicRequestSuccess() {
        let expectation = self.expectation(description: "Success callback is called")
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = "{\"key\":\"value\"}".data(using: .utf8)
            return (response, data)
        }
        
        NetworkManager.basicRequest(
            url: "/test",
            method: .get,
            session: session,
            successCallback: { data in
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                XCTAssertNotNil(json)
                expectation.fulfill()
            },
            errorCallback: { _ in
                XCTFail("Error callback should not be called")
            },
            networkErrorCallback: { _ in
                XCTFail("Network error callback should not be called")
            }
        )
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testBasicRequestError() {
        let expectation = self.expectation(description: "Error callback is called")
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = "{\"error\":\"something went wrong\"}".data(using: .utf8)
            return (response, data)
        }
        
        NetworkManager.basicRequest(
            url: "/test",
            method: .get,
            session: session,
            successCallback: { _ in
                XCTFail("Success callback should not be called")
            },
            errorCallback: { data in
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                XCTAssertNotNil(json)
                expectation.fulfill()
            },
            networkErrorCallback: { _ in
                XCTFail("Network error callback should not be called")
            }
        )
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testBasicRequestNetworkError() {
        let expectation = self.expectation(description: "Network error callback is called")
        
        MockURLProtocol.requestHandler = { request in
            throw NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil)
        }
        
        NetworkManager.basicRequest(
            url: "/test",
            method: .get,
            session: session,
            successCallback: { _ in
                XCTFail("Success callback should not be called")
            },
            errorCallback: { _ in
                XCTFail("Error callback should not be called")
            },
            networkErrorCallback: { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        )
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
