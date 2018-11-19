//
//  Article.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

struct Article: Codable {
    var image: FeaturedImage
    var title: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case image = "featured_image"
        case title = "uppertitle_raw"
        case description = "title"
    }
    
    init(title: String, description: String, image: FeaturedImage) {
        self.title = title
        self.description = description
        self.image = image
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
