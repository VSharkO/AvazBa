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
    func getArticlesFromURL(link: String) -> Observable<[Article]>
    func getSpecificArticleFromURL(link: String) -> Observable<SpecificArticle>
}

extension ArticleInteractor{
    func getArticlesFromURL(link: String) -> Observable<[Article]>{
        return NetworkHelper.GetDataFromApi(with: link).map({ data -> [Article] in
            let articles = try ArticlesDecoderFactory.getDecoder().decode(Response.self, from: data)
            return articles.articles
        })
    }

    func getSpecificArticleFromURL(link: String) -> Observable<SpecificArticle>{
        return NetworkHelper.GetDataFromApi(with: link).map({ data -> SpecificArticle in
            let article = try ArticlesDecoderFactory.getDecoder().decode(SpecificArticle.self, from: data)
            return article
        })
    }
    
}
