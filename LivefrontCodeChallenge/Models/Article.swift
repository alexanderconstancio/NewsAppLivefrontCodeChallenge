//
//  Article.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/5/21.
//

import Foundation
import UIKit

struct Article: Decodable {
    let title: String
    let url: String
    let byline: String
    let section: String
    let source: String
    let media: [JSONImage]
    let date: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case url = "url"
        case byline = "byline"
        case section = "section"
        case source = "source"
        case media = "media"
        case date = "published_date"
        case type = "type"
    }
}

struct Articles: Decodable {
    let all: [Article]
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
}

struct JSONImage: Decodable {
    let metaData: [JSONImgMetaData]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "media-metadata"
    }
}

struct JSONImgMetaData: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}
