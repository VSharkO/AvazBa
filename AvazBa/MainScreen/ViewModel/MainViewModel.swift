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
    var pageCounter = 1
    var pullToRefreshFlag = false
    var moreDataFlag = true
    let repository: RepositoryProtocol
    let scheduler : SchedulerType
    var selectedTab: String = "najnovije"
    var dataRequestTrigered = PublishSubject<(Int,String)>()
    
    var viewShowLoader = PublishSubject<Bool>()
    var viewReloadData = PublishSubject<Bool>()
    var viewInsertRows = PublishSubject<[IndexPath]>()
    var viewReloadRows = PublishSubject<[IndexPath]>()
    
    init(repository: RepositoryProtocol, schedulare: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.repository = repository
        self.scheduler = schedulare
    }
    func initGetingDataFromRepository() -> Disposable {
        return dataRequestTrigered.flatMap({ [unowned self] num -> Observable<[Article]> in
            if !self.pullToRefreshFlag{
                self.pullToRefreshFlag = true
                self.viewShowLoader.onNext(true)
            }
            
            if self.pageCounter>1 {
                self.data.append(LoaderCellType())
                self.viewInsertRows.onNext([IndexPath(item: self.data.count-1, section: 0)])
            }
            return self.repository.getMostPopularArticles(pageNum: self.pageCounter, category: self.selectedTab)
        }).subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] articles in
                if self.pageCounter>1{
                var arrayOfIndexPaths = [IndexPath]()
                for element in Array(self.data.count..<self.data.count+articles.count-1){
                arrayOfIndexPaths.append(IndexPath.init(row: element, section: 0))
                }
                self.data.remove(at: self.data.count-1)
                self.data.append(contentsOf: articles)
                self.viewInsertRows.onNext(arrayOfIndexPaths)
                self.viewReloadRows.onNext([IndexPath(item: self.data.count-articles.count, section: 0)])
                self.viewShowLoader.onNext(false)
                self.pageCounter += 1
                self.moreDataFlag = true
                }
                else{
                    self.data = articles
                    self.refreshViewControllerTableData()
                    self.viewShowLoader.onNext(false)
                    self.pageCounter += 1
                    self.moreDataFlag = true
                }
        })
    }

    func moreDataRequest(){
        dataRequestTrigered(pageNum: pageCounter, category: selectedTab)
    }
    
    func pullToRefresh(){
        data = []
        pageCounter = 1
        dataRequestTrigered(pageNum: pageCounter, category: selectedTab)
    }
    
    func dataRequestTrigered(pageNum: Int, category: String){
        if moreDataFlag{
            self.moreDataFlag = false
            dataRequestTrigered.onNext((pageNum,category))
        }
    }
    
    private func refreshViewControllerTableData() {
        viewReloadData.onNext(true)
    }
}
