//
//  Repository.swift
//  AvazBa
//
//  Created by Valentin Šarić on 18/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift

struct constants{
    static let baseUrl = "http://api.avaz.ba/"
    static let api = "api/"
    static let num = "/1?"
    static let apiToken = "api_token=bXd5Dvw1MGZlb9LrNsmDSA6Nv5Gz21oD4SgEOo4QPs0Nv3VAHYFa6oquDdJe"
    static let pageNumber = "&stranica="
}


class Repository : RepositoryProtocol,Interactor{
    func getMostPopularArticles(pageNum: Int, category: String) -> Observable<[Article]> {
        return getDataFromURL(link: constants.baseUrl + constants.api + category + constants.num + constants.apiToken + constants.pageNumber + String(pageNum))
    }
}
