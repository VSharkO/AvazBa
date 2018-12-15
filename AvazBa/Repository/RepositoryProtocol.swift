//
//  RepositoryProtocol.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift

protocol RepositoryProtocol{
    var decoder: JSONDecoder!{get set}
    func getMostPopularArticles(pageNum: Int, category: String) -> Observable<[Article]>
    func getSpecificArticle(id: Int) -> Observable<SpecificArticle>
}
