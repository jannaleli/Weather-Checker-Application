//
//  weatherAppTests.swift
//  weatherAppTests
//
//  Created by Jann Aleli Zaplan on 2/4/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import XCTest
@testable import weatherApp

class weatherAppTests: XCTestCase {
var sessionUnderTest: URLSession!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
          sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
    }

    func testCompletion() {
        // given
        let url = URL(string: "https://samples.openweathermap.org/data/2.5/forecast?id=1880252&appid=b6907d289e10d714a6e88b30761fae22")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
