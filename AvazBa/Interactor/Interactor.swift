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
    func getArticlesFromURL(link: String) -> Observable<[Article]>
    func getSpecificArticleFromURL(link: String) -> Observable<SpecificArticle>
}

extension Interactor{
    func getArticlesFromURL(link: String) -> Observable<[Article]>{
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
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.000000"
                            //                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            decoder.dateDecodingStrategy = .formatted(formatter)
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
    
    func getSpecificArticleFromURL(link: String) -> Observable<SpecificArticle>{
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
//                            let formatter = DateFormatter()
//                            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.000000"
//                            decoder.keyDecodingStrategy = .convertFromSnakeCase
//                            decoder.dateDecodingStrategy = .formatted(formatter)
                            let article = try decoder.decode(SpecificArticle.self, from: data)
                            observer.onNext(article)
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
