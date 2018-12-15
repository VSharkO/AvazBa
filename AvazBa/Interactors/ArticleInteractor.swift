//
//  Interactor.swift
//  NewsApp
//
//  Created by Valentin Šarić on 23/10/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleInteractor{
    func getArticlesFromURL(link: String, decoder: JSONDecoder) -> Observable<[Article]>
    func getSpecificArticleFromURL(link: String, decoder: JSONDecoder) -> Observable<SpecificArticle>
}

extension ArticleInteractor{
    func getArticlesFromURL(link: String, decoder: JSONDecoder) -> Observable<[Article]>{
        return NetworkHelper.GetDataFromApi(with: link).map({ data -> [Article] in
            let articles = try decoder.decode(Response.self, from: data)
            return articles.articles
        })
    }

    func getSpecificArticleFromURL(link: String, decoder: JSONDecoder) -> Observable<SpecificArticle>{
        return NetworkHelper.GetDataFromApi(with: link).map({ data -> SpecificArticle in
            let article = try decoder.decode(SpecificArticle.self, from: data)
            return article
        })
        
    }
}
