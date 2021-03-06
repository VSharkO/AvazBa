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
    func getArticlesFromURL(link: String) -> Observable<Response>
    func getSpecificArticleFromURL(link: String) -> Observable<SpecificArticle>
}

extension ArticleInteractor{
    func getArticlesFromURL(link: String) -> Observable<Response>{
        return NetworkHelper.getDataFromApi(with: link)
    }

    func getSpecificArticleFromURL(link: String) -> Observable<SpecificArticle>{
        return NetworkHelper.getDataFromApi(with: link)
    }
}
