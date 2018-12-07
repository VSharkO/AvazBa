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
    var data: [Cell] = []
    
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
                self.data.append(Cell(cellType: SingleArticleCellTypes.title, data: article.title))
                self.data.append(Cell(cellType: SingleArticleCellTypes.image, data: article.featuredImage.original))
                
                for content in article.content{
                    if content.type == "text"{
                        self.data.append(Cell(cellType: SingleArticleCellTypes.text, data: content.data))
                    }
                }
                
                self.data.append(Cell(cellType: SingleArticleCellTypes.upperTitle, data: article.upperTitle))
                
                if let relatedArticles = article.autoRelatedArticles{
                    for article in relatedArticles{
                        self.data.append(Cell(cellType: SingleArticleCellTypes.relatedNews, data: article))
                    }
                }
                
                if let title = self.data[0].data as! String?, let image = self.data[1].data as! String?, let text = self.data[2].data as! String?, let upperTitle = self.data[3].data as! String?{
                    print(title + image + text + upperTitle)
                }
            })
    }

    func getSpecificArticle(){
        dataRequestTriger.onNext(true)
    }
    
    func getData() -> [Cell]{
        return data
    }
    
}
