//
//  NetworkHelper.swift
//  AvazBa
//
//  Created by Valentin Šarić on 17/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class NetworkHelper{
    static func GetDataFromApi(with link: String) -> Observable<Data>{
        return Observable.deferred({
            return Observable.create{ observer -> Disposable in
                let request = Alamofire.request(link)
                    .validate()
                    .responseJSON{response in
                        guard let data = response.data else{
                            observer.onError(response.error!)
                            return
                        }
                        observer.onNext(data)
                }
                return Disposables.create{
                    request.cancel()
                }
            }
        })
    }
}
