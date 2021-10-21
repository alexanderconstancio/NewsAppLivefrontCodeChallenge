//
//  MockNYTApiServiceClient.swift
//  LivefrontCodeChallengeTests
//
//  Created by Alex Constancio on 10/20/21.
//

import XCTest
import Alamofire
import SwiftSoup
@testable import LivefrontCodeChallenge

/// Mock NYT API service client for unit testing
class Mock_NYT_API_Client {
    static var shouldReturnError = false
    static var requestArticlesWasCalled = false
    static var requestArticleParaWasCalled = false
    static var paraFetchShouldReturnError = false
    
    enum MockApiError: Error {
        case requestArticles
        case requestArticleParagraphs
    }
    
    /// Reset triggers to original state
    func reset() {
        Mock_NYT_API_Client.shouldReturnError = false
        Mock_NYT_API_Client.requestArticlesWasCalled = false
        Mock_NYT_API_Client.requestArticleParaWasCalled = false
        Mock_NYT_API_Client.paraFetchShouldReturnError = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        Mock_NYT_API_Client.shouldReturnError = shouldReturnError
    }
}

extension Mock_NYT_API_Client: NYT_API_Protocol {
    static func fetchPopularArticlesBy(timeframe: NYT_APITimeframes, completion: @escaping ([Article], AFError?) -> Void) {
        requestArticlesWasCalled = true
        // Force error to be thrown
        if shouldReturnError {
            completion([Article](), AFError.createURLRequestFailed(error: MockApiError.requestArticles))
        }
    }
    
    static func parseArticleHTMLFromURL(articleURLString: String, completion: @escaping ([String], Exception?) -> Void) {
        requestArticleParaWasCalled = true
        // Force error to be thrown 
        if paraFetchShouldReturnError {
            completion([String](), Exception.Error(type: .IllegalArgumentException, Message: "Illegal argument inserted."))
        }
    }
}
