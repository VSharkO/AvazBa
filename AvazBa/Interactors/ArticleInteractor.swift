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
        return NetworkHelper.GetDataFromApi(with: link, ofType: Response.self)
    }

    func getSpecificArticleFromURL(link: String) -> Observable<SpecificArticle>{
        return NetworkHelper.GetDataFromApi(with: link, ofType: SpecificArticle.self)
    }
    
}
