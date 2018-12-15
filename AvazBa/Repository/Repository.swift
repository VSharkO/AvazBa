//
//  Repository.swift
//  AvazBa
//
//  Created by Valentin Šarić on 18/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift

class Repository : RepositoryProtocol,ArticleInteractor{
    var decoder: JSONDecoder!
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
        decoder.dateDecodingStrategy = .formatted(ArticleDateFormatter.getFormater())
    }
    
    func getMostPopularArticles(pageNum: Int, category: String) -> Observable<[Article]> {
        return getArticlesFromURL(link: Constants.baseUrl + Constants.api + category + Constants.num + Constants.apiToken + Constants.pageNumber + String(pageNum), decoder: decoder)
    }
    
    func getSpecificArticle(id: Int) -> Observable<SpecificArticle> {
         return getSpecificArticleFromURL(link: Constants.baseUrl + Constants.api + Constants.article + String(id) + Constants.apiToken, decoder: decoder)
    }

}
