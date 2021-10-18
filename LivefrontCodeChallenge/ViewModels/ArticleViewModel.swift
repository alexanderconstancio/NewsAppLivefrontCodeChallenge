//
//  ArticleViewModel.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/5/21.
//

import Foundation
import Nuke

/// The view model is initialized with an Article object and prepares the view for data
struct ArticleViewModel {
    let title: String
    let url: String
    let byline: String
    let section: String
    let source: String
    let jsonImg: JSONImage
    let date: String
    
    init(article: Article) {
        self.title = article.title
        self.url = article.url
        self.byline = article.byline
        self.section = article.section
        self.source = article.source
        self.jsonImg = article.media.first ?? JSONImage(metaData: [JSONImgMetaData]())
        
        let rawDate = article.date

        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: rawDate)!
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        
        self.date = dateString
    }
}

