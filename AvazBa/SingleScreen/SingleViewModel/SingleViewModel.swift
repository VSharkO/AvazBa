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
        return dataRequestTriger.flatMap({ [unowned self] _ -> Observable<(SpecificArticle,[Article])> in
            Observable.zip(self.repository.getSpecificArticle(id: self.id), self.repository.getMostPopularArticles(pageNum: 1, category: constants.mostRead))
        }).subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] article,arrayOfRelated in
                self.data.append(Cell(cellType: SingleArticleCellTypes.image, data: article.featuredImage.original))
                self.data.append(Cell(cellType: SingleArticleCellTypes.upperTitle, data: article.upperTitle))
                self.data.append(Cell(cellType: SingleArticleCellTypes.title, data: article.title))
                for content in article.content{
                    if content.type == constants.text{
                        self.data.append(Cell(cellType: SingleArticleCellTypes.text, data: content.data))
                    }
                }
                if let relatedArticles = article.autoRelatedArticles{
                    for article in relatedArticles{
                        self.data.append(Cell(cellType: SingleArticleCellTypes.relatedNews, data: article))
                    }
                }
                self.data.append(Cell(cellType: SingleArticleCellTypes.mostReadTitle, data: constants.mostRead))
                for i in 0...6{
                    self.data.append(Cell(cellType: SingleArticleCellTypes.mostReadNews, data: arrayOfRelated[i]))
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
