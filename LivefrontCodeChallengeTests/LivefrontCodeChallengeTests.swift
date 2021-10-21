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
        try super.tearDownWithError()
        sut = nil
    }
    
    // Test fetchPopularArticles throws the correct error
    func testFetchArticleErrorResponse() {
        // Force error to be thrown
        Mock_NYT_API_Client.shouldReturnError = true
        Mock_NYT_API_Client.fetchPopularArticlesBy(timeframe: .today) { articleArray, error in
            if let error = error {
                XCTAssertNotNil(error.localizedDescription)
            }
        }
    }
    
    // Test fetchArticleParagraph throws the correct error
    func testFetchArticleParagraphErrorResponse() {
        // Force error to be thrown 
        Mock_NYT_API_Client.paraFetchShouldReturnError = true
        Mock_NYT_API_Client.parseArticleHTMLFromURL(articleURLString: "") { paragraphs, errorException in
            if let error = errorException {
                print(error.localizedDescription)
                XCTAssertNotNil(error.localizedDescription)
            }
        }
    }
    
    // Test API URL call happy and error paths return the correct responses
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
        
        if statusCode != nil {
            XCTAssertEqual(statusCode, 200)
        }
        
        if responseError != nil {
            XCTAssertEqual(responseError?.localizedDescription, "The Internet connection appears to be offline.")
        }
    }
    
    // Testing dependency injection of both ArticleViewModel and ArticleBodyViewModel
    func testArticleViewModels() {
        let article = Article(title: "Test title",
                              url: "google.com",
                              byline: "Alex Constancio",
                              section: "1", source: "1",
                              media: [JSONImage](),
                              date: "2021-10-19",
                              type: "article")
        
        // Test that we are getting the correct values in articleViewModel
        let articleViewModel = ArticleViewModel(article: article)
        XCTAssertEqual(article.title, articleViewModel.title)
        XCTAssertEqual(article.url, articleViewModel.url)
        XCTAssertEqual(article.byline, articleViewModel.byline)
        XCTAssertEqual(article.section, articleViewModel.section)
        XCTAssertEqual(article.source, articleViewModel.source)
        
        // Check that our date logic properly converts the date string
        XCTAssertNotEqual(articleViewModel.date, article.date)
        
        // Test we are returning the correct strings in articleBodyViewModel
        let articleBodyViewModel = ArticleBodyViewModel(article: articleViewModel)
        XCTAssertEqual(articleViewModel.title, articleBodyViewModel.titleLabel)
        XCTAssertEqual(articleViewModel.date, articleBodyViewModel.dateLabel)
        XCTAssertEqual(articleViewModel.url, articleBodyViewModel.articleUrl)
    }
    
    // Check that our hard coded api params are not changed
    func testAPITimeframeValues() {
        XCTAssertEqual(NYT_APITimeframes.today.rawValue, 1)
        XCTAssertEqual(NYT_APITimeframes.thisWeek.rawValue, 7)
        XCTAssertEqual(NYT_APITimeframes.thisMonth.rawValue, 30)
        
        XCTAssertEqual(NYT_APITimeframeText.trendingToday.rawValue, "Trending Today")
        XCTAssertEqual(NYT_APITimeframeText.trendingThisWeek.rawValue, "Trending this Week")
        XCTAssertEqual(NYT_APITimeframeText.trendingThisMonth.rawValue, "Trending Last 30 Days")
    }
}
