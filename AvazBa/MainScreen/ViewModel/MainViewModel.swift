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
    var requestInProgress = false
    var state: State = State.idle
    
    let repository: RepositoryProtocol
    let scheduler : SchedulerType
    var selectedTab: String = Constants.newestApi
    var dataRequestTriger = ReplaySubject<Bool>.create(bufferSize: 1)
    var viewShowLoader = PublishSubject<Bool>()
    var viewReloadData = PublishSubject<Bool>()
    var viewInsertRows = PublishSubject<[IndexPath]>()
    var viewReloadRows = PublishSubject<[IndexPath]>()
    var viewReloadRowsForNewTab = PublishSubject<(Int,Int)>()
    
    init(repository: RepositoryProtocol, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.repository = repository
        self.scheduler = scheduler
    }
    
    func initGetingDataFromRepository() -> Disposable {
        return dataRequestTriger.flatMap({ [unowned self] _ -> Observable<Response> in
            switch self.state{
            case State.initialRequest:
                self.viewShowLoader.onNext(true)
            case State.moreArticles:
                self.data.append(LoaderCellType())
                self.viewInsertRows.onNext([IndexPath(item: self.data.count-1, section: 0)])
            default: print("Data refreshed")
            }
            print(self.pageCounter)
            return self.repository.getMostPopularArticles(pageNum: self.pageCounter, category: self.selectedTab)
        }).subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] response in
                switch self.state{
                case .moreArticles:
                    self.moreArticles(articles: response.articles)
                    self.state = .idle
                case .initialRequest, .pullToRefresh:
                    self.restartTableData(with: response.articles)
                    self.state = .idle
                case State.newTabOpened:
                    self.setupNewTab(with: response.articles)
                    self.state = State.idle
                default: return
                }
            })
    }
    
    private func setupNewTab(with articles: [Article]){
        let oldNumOfData = self.data.count
        self.data = articles
        self.viewReloadRowsForNewTab.onNext((self.data.count, oldNumOfData))
        self.viewShowLoader.onNext(false)
        self.pageCounter += 1
        self.requestInProgress = false
    }
    
    private func moreArticles(articles: [Article]){
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
        self.requestInProgress = false
    }
    
    private func restartTableData(with articles: [Article]){
        self.data = articles
        self.refreshViewControllerTableData()
        self.viewShowLoader.onNext(false)
        self.pageCounter += 1
        self.requestInProgress = false
    }
    
    func moreDataRequest() {
        state = .moreArticles
        dataRequestTrigered()
    }
    
    func newTabOpened(){
        state = .newTabOpened
        pageCounter = 1
        dataRequestTrigered()
    }
    
    func pullToRefreshTrigered() {
        state = .pullToRefresh
        pageCounter = 1
        dataRequestTrigered()
    }
    
    func initialDataRequest(){
        state = .initialRequest
        pageCounter = 1
        dataRequestTrigered()
    }
    
    func getIDs() -> [Int] {
        var ids : [Int] = []
        for article in data{
            if let currentArticle = article as? Article{
                ids.append(currentArticle.id)
            }
        }
        return ids
    }
    
    private func dataRequestTrigered(){
        if !requestInProgress{
            requestInProgress = true
            dataRequestTriger.onNext(true)
        }
    }
    
    private func refreshViewControllerTableData() {
        viewReloadData.onNext(true)
    }
    
}
