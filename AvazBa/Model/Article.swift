//
//  Article.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

struct Article{
    private var urlToImage: String
    private var title: String
    private var description: String
    
    init(title: String, description: String, urlToImage: String) {
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
    }
}
