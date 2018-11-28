//
//  Repository.swift
//  AvazBa
//
//  Created by Valentin Šarić on 18/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift

class Repository : RepositoryProtocol,Interactor{
    func getMostPopularArticles(pageNum: Int, category: String) -> Observable<[Article]> {
        return getDataFromURL(link: constants.baseUrl + constants.api + category + constants.num + constants.apiToken + constants.pageNumber + String(pageNum))
    }
}
