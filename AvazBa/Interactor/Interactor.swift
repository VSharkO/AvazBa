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

protocol Interactor{
    func getDataFromURL(link: String) -> Observable<[Article]>
}

extension Interactor{
    func getDataFromURL(link: String) -> Observable<[Article]>{
        return Observable.deferred({
            return Observable.create{ observer -> Disposable in
                let request = Alamofire.request(link)
                    .validate()
                    .responseJSON{response in
                        guard let data = response.data else{
                            observer.onError(response.error!)
                            return
                        }
                        do{
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let articles = try decoder.decode(Response.self, from: data)
                            observer.onNext(articles.articles)
                        } catch {
                            observer.onError(error)
                        }
                }
                return Disposables.create{
                    request.cancel()
                }
            }
            }
        )}
}
