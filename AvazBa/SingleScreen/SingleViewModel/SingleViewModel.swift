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
    var dataRequestTriger = ReplaySubject<Bool>.create(bufferSize: 1)
    var viewShowLoader = PublishSubject<Bool>()
    var viewReloadData = PublishSubject<Bool>()
    var data: [Section] = []
    
    init(repository: RepositoryProtocol, id: Int, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.id = id
        self.scheduler = scheduler
        self.repository = repository
    }
    
    func initGetingDataFromRepository() -> Disposable {
        return dataRequestTriger.flatMap({ [unowned self] _ -> Observable<(SpecificArticle,[Article])> in
            self.viewShowLoader.onNext(true)
          let observables = Observable.zip(self.repository.getSpecificArticle(id: self.id), self.repository.getMostPopularArticles(pageNum: 1, category: Constants.mostReadApi))
            return observables
        }).subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] article,mostRead in
                var articleSecton = Section(sectionType: SectionType.article, data: [Cell]())
                var relatedSection = Section(sectionType: SectionType.related, data: [Cell]())
                var mostReadSecton = Section(sectionType: SectionType.mostRead, data: [Cell]())
                //Add content in sections
                articleSecton.data.append(Cell(cellType: SingleArticleCellTypes.image, data: article))
                articleSecton.data.append(Cell(cellType: SingleArticleCellTypes.upperTitle, data: article.upperTitle))
                articleSecton.data.append(Cell(cellType: SingleArticleCellTypes.title, data: article.title))
                articleSecton.data.append(Cell(cellType: SingleArticleCellTypes.titleRow, data: article.titleRaw))
                articleSecton.data.append(Cell(cellType: SingleArticleCellTypes.publishedCell, data: article))
                for content in article.content{
                    if content.type == Constants.text{
                        articleSecton.data.append(Cell(cellType: SingleArticleCellTypes.text, data: content.data))
                        break
                    }
                }
                if let relatedArticles = article.autoRelatedArticles{
                    for article in relatedArticles{
                        relatedSection.data.append(Cell(cellType: SingleArticleCellTypes.relatedNews, data: article))
                    }
                }
                for i in 0...5{
                    mostReadSecton.data.append(Cell(cellType: SingleArticleCellTypes.mostReadNews, data: mostRead[i]))
                }
                
                //Add sections to sectionArray
                self.data.append(articleSecton)
                if relatedSection.data.count > 0{
                    self.data.append(relatedSection)
                }
                self.data.append(mostReadSecton)
                self.viewShowLoader.onNext(false)
                self.refreshViewControllerTableData()
            })
    }

    func getSpecificArticle(){
        dataRequestTriger.onNext(true)
    }
    
    private func refreshViewControllerTableData() {
        viewReloadData.onNext(true)
    }

}
