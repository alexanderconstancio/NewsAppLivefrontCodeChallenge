//
//  NYT-API-Service.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/7/21.
//

import Foundation
import Alamofire
import SwiftSoup

// MARK:- New York Times API helper functions
/// Timeframes provided to the NYT networking call that return articles in a specific time range
enum NYT_APITimeframes: Int {
    /// Popular articles from past day
    case today = 1
    /// Popular articles from past week
    case thisWeek = 7
    /// Popular articles from past month
    case thisMonth = 30
}

/// Timeframe string used for cell header text label informing the user what the current timeframe is set at
enum NYT_APITimeframeText: String {
    /// Popular articles from past day
    case trendingToday = "Trending Today"
    /// Popular articles from past week
    case trendingThisWeek = "Trending this Week"
    /// Popular articles from past month
    case trendingThisMonth = "Trending Last 30 Days"
}

/// Contains a set of functions that make calls to the NY Times API
class NYT_APIService: NYT_API_Protocol {
    static let NYTimesApiUrl = "https://api.nytimes.com"
    static let NYTimesApiKey = "s5YewlU65On9NVndBUIX1x15O60iQmvD"
    
    /// Returns popular articles by the provided time frame
    /// ```
    /// Timeframes
    /// .today = Popular articles from today
    /// .thisWeek = Popular articles from last 7 days
    /// .thisMonth = Articles from previous 30 days
    /// ```
    static func fetchPopularArticlesBy(timeframe: NYT_APITimeframes, completion: @escaping ([Article], AFError?) -> Void) {
        let timeFrameParam = "\(timeframe.rawValue)"
        let NYTimesPopularUrl = "\(NYTimesApiUrl)/svc/mostpopular/v2/viewed/\(timeFrameParam).json?api-key="
        var onlyArticleArray = [Article]()
        AF.request(NYTimesPopularUrl + NYTimesApiKey)
            .validate()
            .responseDecodable(of: Articles.self) { response in
                guard let articleArray = response.value?.all else { return }
                articleArray.forEach { article in
                    if article.type == "Article" {
                        onlyArticleArray.append(article)
                    }
                    completion(onlyArticleArray, response.error)
                }
        }
        // Article fetching will time out after 8 seconds if no articles were found
        // and will throw an explicit cancellation error
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            if onlyArticleArray.isEmpty {
                completion(onlyArticleArray, AFError.explicitlyCancelled)
            }
        }
    }
    
    /// Insert an article url and this function will return an array of paragraph strings containing the body of the provided article.
    static func parseArticleHTMLFromURL(articleURLString: String, completion: @escaping ([String], Exception?) -> Void) {
        var articleParagraphs = [String]()
        
            guard let url = URL(string: articleURLString) else { return }
            let html = try? String(contentsOf: url, encoding: .utf8)
            do {
                guard let html = html else { return }
                let doc: Document = try SwiftSoup.parseBodyFragment(html)
                let paragraph: [Element] = try doc.select("p").array()

                try paragraph.forEach { para in
                    let getArticleSum: Element? = try para.getElementById("article-summary")
                    let getNameClass: Elements? = try para.getElementsByClass("e1jsehar1")
                    let paraText = try para.text()

                    if paraText != "Advertisement"
                        && paraText != "Supported by"
                        && paraText != "transcript"
                        && para != getArticleSum
                        && para != getNameClass?.first() {
                            articleParagraphs.append(paraText)
                        }
                    }
                completion(articleParagraphs, nil)
            } catch Exception.Error(_, let message) {
                print("Message: \(message)")
            } catch {
                print("error")
            }
    }
}


