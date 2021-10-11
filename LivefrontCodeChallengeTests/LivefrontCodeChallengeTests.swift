//
//  LivefrontCodeChallengeTests.swift
//  LivefrontCodeChallengeTests
//
//  Created by Alex Constancio on 9/30/21.
//

import XCTest
@testable import LivefrontCodeChallenge

class LivefrontCodeChallengeTests: XCTestCase {
    
    var sut: URLSession!

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
    }
    
    func testValidApiCallGetsHTTPStatusCode200() throws {
        
        let NYTimesApiUrl = "https://api.nytimes.com"
        let NYTimesApiKey = "s5YewlU65On9NVndBUIX1x15O60iQmvD"
        let urlString = "\(NYTimesApiUrl)/svc/mostpopular/v2/viewed/1.json?api-key="
        let url = URL(string: urlString + NYTimesApiKey)!
        let promise = expectation(description: "Status code: 200")

        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testApiCallCompletes() throws {
        let NYTimesApiUrl = "https://api.nytimes.com"
        let NYTimesApiKey = "s5YewlU65On9NVndBUIX1x15O60iQmvD"
        let urlString = "\(NYTimesApiUrl)/svc/mostpopular/v2/viewed/1.json?api-key="
        let url = URL(string: urlString + NYTimesApiKey)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        let dataTask = sut.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)

        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

    func testParseHtmlSpeed() throws {
        self.measure {
            for _ in 0..<10 {
                NYT_APIService.parseArticleHTMLFromURL(articleURLString: "https://www.nytimes.com/interactive/2014/upshot/dialect-quiz-map.html") { CFStringCreateArray in
                    
                }
            }
        }
    }
}
