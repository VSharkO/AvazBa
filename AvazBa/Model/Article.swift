//
//  Article.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

struct Article: Codable,CellItem {
    var cellType: CellType = .article
    var image: FeaturedImage
    var title: String
    var description: String
    var shares: Int
    var publishedAt: PublishedAt
    var id: Int
    var category: String
    
    enum CodingKeys: String, CodingKey {
        case image = "featured_image"
        case title = "uppertitle_raw"
        case description = "title"
        case shares = "shares"
        case publishedAt = "published_at"
        case id = "id"
        case category = "category_slug"
    }
}

struct PublishedAt: Codable{
    var date: Date
    var timezoneType: Int
    var timezone: String

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case timezoneType = "timezone_type"
        case timezone = "timezone"
    }
}

struct FeaturedImage: Codable {
    var original: String
}

struct Response : Codable {
    let name: String
    let slug: String
    let category_id: String
    let articles : [Article]
}
