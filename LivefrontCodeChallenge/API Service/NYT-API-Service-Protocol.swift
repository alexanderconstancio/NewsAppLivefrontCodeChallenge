//
//  NYT-API-Service-Protocol.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/20/21.
//

import Foundation
import Alamofire
import SwiftSoup

protocol NYT_API_Protocol {
    /// Returns popular articles by the provided time frame
    static func fetchPopularArticlesBy(timeframe: NYT_APITimeframes, completion: @escaping ([Article], AFError?) -> Void)
    /// Insert an article url and this function will return an array of paragraph strings containing the body of the provided article.
    static func parseArticleHTMLFromURL(articleURLString: String, completion: @escaping ([String], Exception?) -> Void)
}
