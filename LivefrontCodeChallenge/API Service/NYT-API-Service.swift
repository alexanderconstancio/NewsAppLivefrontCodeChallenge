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

/// Contains a set of functions that make calls to the NY Times API
class NYT_APIService {
    
    static let NYTimesApiUrl = "https://api.nytimes.com"
    static let NYTimesApiKey = "s5YewlU65On9NVndBUIX1x15O60iQmvD"
    
    /// Returns popular articles by the provided time frame
    /// ```
    /// Timeframes
    /// 1 = Popular articles from today
    /// 7 = Popular articles from last 7 days
    /// 30 = Articles from previous 30 days
    /// ```
    static func fetchPopularArticlesBy(timeframe: Int, completion: @escaping ([Article], AFError?) -> Void) {
        
        let timeFrameParam = "\(timeframe)"
        let NYTimesPopularUrl = "\(NYTimesApiUrl)/svc/mostpopular/v2/viewed/\(timeFrameParam).json?api-key="
        
        AF.request(NYTimesPopularUrl + NYTimesApiKey)
            .validate()
            .responseDecodable(of: Articles.self) { response in
                var onlyArticleArray = [Article]()
                guard let articleArray = response.value?.all else { return }
                
                articleArray.forEach { article in
                    if article.type == "Article" {
                        onlyArticleArray.append(article)
                    }
                    
                    completion(onlyArticleArray, response.error)
                }
        }
    }
    
    /// Insert an article url and this function will return an array of paragraph strings containing the body of the provided article.
    static func parseArticleHTMLFromURL(articleURLString: String, completion: @escaping ([String]) -> Void) {
        
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
            
            completion(articleParagraphs)
            
        } catch Exception.Error(_, let message) {
            print("Message: \(message)")
        } catch {
            print("error")
        }
    }
}


