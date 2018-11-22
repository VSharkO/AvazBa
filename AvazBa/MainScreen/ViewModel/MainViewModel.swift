//
//  MainViewModel.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel : MainViewModelProtocol{
    
    internal var data: [CellItem] = []
    var pageCounter = 0
    var pullToRefreshFlag = false
    var moreDataFlag = true
    let repository: RepositoryProtocol
    let scheduler : SchedulerType
    var dataRequestTrigered = PublishSubject<Int>()
    
    var viewShowLoader = PublishSubject<Bool>()
    var viewReloadData = PublishSubject<Bool>()
    var viewInsertRows = PublishSubject<[IndexPath]>()
    var viewDeleteRow = PublishSubject<Int>()
    
    init(repository: RepositoryProtocol, schedulare: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.repository = repository
        self.scheduler = schedulare
    }
    func initGetingDataFromRepository() -> Disposable {
        let lastDataCount = data.count
        return dataRequestTrigered.flatMap({ [unowned self] num -> Observable<[Article]> in
            if !self.pullToRefreshFlag{
                self.pullToRefreshFlag = true
                self.viewShowLoader.onNext(true)
            }
            self.pageCounter = num
            return self.repository.getMostPopularArticles(pageNum: self.pageCounter)
        }).subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] articles in
                if self.pageCounter > 1{
                    self.data.remove(at: self.data.count-1)
                    self.viewDeleteRow.onNext(self.data.count-1)
                    
                    var arrayOfIndexPaths = [IndexPath]()
                    for element in Array(lastDataCount..<lastDataCount+articles.count){
                        arrayOfIndexPaths.append(IndexPath.init(row: element, section: 0))
                    }
                    self.data.append(contentsOf: articles)
                    self.viewInsertRows.onNext(arrayOfIndexPaths)
                    self.viewShowLoader.onNext(false)
                    self.moreDataFlag = true
                }else{
//                    self.data.remove(at: self.data.count-1)
//                    self.viewDeleteRow.onNext(self.data.count-1)
//                    var arrayOfIndexPaths = [IndexPath]()
                    print(Array(self.data.count..<lastDataCount+articles.count))
//                    for element in Array(lastDataCount..<lastDataCount+articles.count){
//                        arrayOfIndexPaths.append(IndexPath.init(row: element, section: 0))
//                    }
                    self.data = articles
                    self.refreshViewControllerTableData()
                    self.viewShowLoader.onNext(false)
                    self.moreDataFlag = true
                }
        })
    }
    
    func moreDataRequest() {
        pageCounter += 1
        dataRequestTrigered(pageNum: pageCounter)
    }
    
    func pullToRefresh(){
        data = []
        dataRequestTrigered(pageNum: 1)
    }
    
    func dataRequestTrigered(pageNum: Int){
        if moreDataFlag{
            self.moreDataFlag = false
//            self.data.append(LoaderCellType())
//            self.viewInsertRows.onNext([IndexPath(item: self.data.count-1, section: 0)])
            dataRequestTrigered.onNext(pageNum)
        }
    }
    
    private func refreshViewControllerTableData() {
        viewReloadData.onNext(true)
    }
}
