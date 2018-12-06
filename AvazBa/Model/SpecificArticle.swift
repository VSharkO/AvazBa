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
    let featuredImage: FeaturedImage
//    let autoRelatedArticles: [Article]
    let content: [ArticleContent]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case featuredImage = "featured_image"
//        case autoRelatedArticles = "auto_related_articles"
        case content = "content"
    }
    
//    init(id: Int, title: String, featuredImage: FeaturedImage, autoRelatedArticles: [Article],content: [ArticleContent]) {
//        self.id = id
//        self.title = title
//        self.featuredImage = featuredImage
//        self.autoRelatedArticles = autoRelatedArticles
//        self.content = content
//    }
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
    
    init(articleId: Int, type: String, data: String){
        self.articleId = articleId
        self.type = type
        self.data = data
    }
}
