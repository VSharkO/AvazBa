//
//  SingleViewModel.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift

class SingleViewModel : SingleViewModelProtocol{
    let id: Int!
    let scheduler : SchedulerType
    let repository: RepositoryProtocol
    var dataRequestTriger = PublishSubject<Bool>()
    var data: [(data: String,typeOfCell: String)] = []
    
    init(repository: RepositoryProtocol, id: Int, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.id = id
        self.scheduler = scheduler
        self.repository = repository
    }
    
    func initGetingDataFromRepository() -> Disposable {
        return dataRequestTriger.flatMap({ [unowned self] _ -> Observable<SpecificArticle> in
            return self.repository.getSpecificArticle(id: self.id)
        }).subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] article in
                self.data.append((String(article.id), "text"))
                self.data.append((article.title, "text"))
                self.data.append((article.featuredImage.original, "text"))
                self.data.append((article.content[0].data, "text"))
                print(self.data[0].data + self.data[1].data + self.data[2].data,self.data[3].data)
            })
    }

    func getSpecificArticle(){
        dataRequestTriger.onNext(true)
    }
    
    func getData() -> [(data: String,typeOfCell: String)]{
        return data
    }
    
}
