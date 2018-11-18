//
//  Repository.swift
//  AvazBa
//
//  Created by Valentin Šarić on 18/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift

class Repository : RepositoryProtocol{
    func getMostPopularArticles() -> Observable<[Article]> {
        return Observable.just([Article(title: "jedan", description: "Dva", urlToImage: "tri")])
    }
    
}
