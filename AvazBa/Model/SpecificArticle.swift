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
    let author: String
    let title: String
    var titleRaw: String
    let upperTitle: String
    let category: String
    let featuredImage: FeaturedImage
    var publishedAt: PublishedAt
    var publishedAtHumans: String
    let imageDescription: String?
    let imageSource: String?
    let shares: Int
    let autoRelatedArticles: [ContentOfRelatedArticle]?
    let content: [ArticleContent]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case titleRaw = "title_raw"
        case upperTitle = "uppertitle"
        case featuredImage = "featured_image"
        case autoRelatedArticles = "auto_related_articles"
        case publishedAt = "published_at"
        case content = "content"
        case category = "category_slug"
        case imageDescription = "featured_image_source"
        case imageSource = "featured_image_caption"
        case publishedAtHumans = "published_at_humans"
        case author = "author"
        case shares = "shares"
    }
}

struct ContentOfRelatedArticle: Codable{
    var image: FeaturedImage
    var title: String
    var description: String
    var shares: Int
    var id: Int
    var category: String
    var publishedAt: PublishedAt
    
    enum CodingKeys: String, CodingKey {
        case image = "featured_image"
        case title = "uppertitle_raw"
        case description = "title"
        case shares = "shares"
        case id = "id"
        case publishedAt = "published_at"
        case category = "category_slug"
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
