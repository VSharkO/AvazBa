//
//  Content.swift
//  AvazBa
//
//  Created by Valentin Šarić on 06/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

struct SpecificArticle : Codable{
    let id: Int
    let title: String
    let upperTitle: String
    let featuredImage: FeaturedImage
    let autoRelatedArticles: [ContentOfRelatedArticle]?
    let content: [ArticleContent]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case upperTitle = "uppertitle"
        case featuredImage = "featured_image"
        case autoRelatedArticles = "auto_related_articles"
        case content = "content"
    }
    
    struct ContentOfRelatedArticle: Codable{
        var image: FeaturedImage
        var title: String
        var description: String
        var shares: Int
        var id: Int
        var category: String
        
        enum CodingKeys: String, CodingKey {
            case image = "featured_image"
            case title = "uppertitle_raw"
            case description = "title"
            case shares = "shares"
            case id = "id"
            case category = "category_slug"
        }
    }
}

struct ArticleContent : Codable{
    let articleId: Int
    let type: String
    let data: String
    
    enum CodingKeys: String, CodingKey {
        case articleId = "article_id"
        case type = "type"
        case data = "data"
    }
}