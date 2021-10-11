//
//  ArticleBodyViewModel.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation

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
        
        NYT_APIService.parseArticleHTMLFromURL(articleURLString: article.url) { paragraphArray in
            self.articleParagraphs = paragraphArray
        }
    }
}
