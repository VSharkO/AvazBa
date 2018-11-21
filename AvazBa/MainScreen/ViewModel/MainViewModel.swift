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

    var data: [Article] = []
    
    let repository: RepositoryProtocol
    let scheduler : SchedulerType
    var dataRequestTrigered = PublishSubject<Int>()
    var viewShowLoader = PublishSubject<Bool>()
    var viewReloadData = PublishSubject<Bool>()
    var pullToRefreshTrigered = PublishSubject<Bool>()
    var moreDataRequestTrigered = PublishSubject<Int>()
    var pullToRefreshFlag = false
     var pageCounter = 1
    
    init(repository: RepositoryProtocol, schedulare: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.repository = repository
        self.scheduler = schedulare
    }
    
    func initGetingDataFromRepository() -> Disposable {
        return dataRequestTrigered.flatMap({ [unowned self] num -> Observable<[Article]> in
            if !self.pullToRefreshFlag && self.pageCounter == 1{self.viewShowLoader.onNext(true)}
            self.pageCounter = num
            return self.repository.getMostPopularArticles(pageNum: self.pageCounter)
        }).subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] articles in
                if self.pageCounter > 1{
                    self.data.append(contentsOf: articles)
                    self.refreshViewModelData()
                    self.viewShowLoader.onNext(false)
                    self.pullToRefreshFlag = false
                }else{
                    self.data = articles
                    self.refreshViewModelData()
                    self.viewShowLoader.onNext(false)
                    self.pullToRefreshFlag = false
                }
        })
    }
    
    func initPullToRefreshHandler() -> Disposable{
        return pullToRefreshTrigered.subscribe(onNext: { [unowned self] _ in
            self.dataRequestTrigered(pageNum: 1)
        })
    }
    
    func initMoreDataRequest() -> Disposable{
        return moreDataRequestTrigered.subscribe(onNext: { [unowned self] pageNum in
            self.dataRequestTrigered(pageNum: pageNum)
        })
    }
    
    private func refreshViewModelData() {
        viewReloadData.onNext(true)
    }
    
    func getData() -> [Article]{
        return data
    }
    
    func moreDataRequest() {
        dataRequestTrigered(pageNum: pageCounter)
        pageCounter += 1
    }
    
    func pullToRefresh(){
        pullToRefreshFlag = true
        pullToRefreshTrigered.onNext(true)
    }
    
    func dataRequestTrigered(pageNum: Int){
        dataRequestTrigered.onNext(pageNum)
    }
}
