//
//  ArticleBodyViewModel.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation

/// Initialized with an ArticleViewModel from the cell. Takes an article URL and returns an array of paragraphs from said article
class ArticleBodyViewModel {
    var articleParagraphs = [String]()
    let articleUrl: String
    let byLabel: String
    let dateLabel: String
    let titleLabel: String
    let jsonImg: JSONImage
    
    init(article: ArticleViewModel) {
        self.articleUrl = article.url
        self.byLabel = article.byline
        self.dateLabel = article.date
        self.titleLabel = article.title
        self.jsonImg = article.jsonImg
        
        // Fetch article paragraphs from url string
        NYT_APIService.parseArticleHTMLFromURL(articleURLString: article.url) { [unowned self] paragraphArray, error in
            if let error = error {
                print("Error getting article paragraphs", error)
            }
            self.articleParagraphs = paragraphArray
        }
    }
}
