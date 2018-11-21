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
    
    internal var data: [Article] = []
    var pageCounter = 0
    var pullToRefreshFlag = false
    var moreDataFlag = true
    
    let repository: RepositoryProtocol
    let scheduler : SchedulerType
    var dataRequestTrigered = PublishSubject<Int>()
    
    var viewShowLoader = PublishSubject<Bool>()
    var viewReloadData = PublishSubject<Bool>()
    
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
            self.pageCounter = num
            self.moreDataFlag = false
            return self.repository.getMostPopularArticles(pageNum: self.pageCounter)
        }).subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] articles in
                if self.pageCounter > 1{
                    self.data.append(contentsOf: articles)
                    self.refreshViewControllerTableData()
                    self.viewShowLoader.onNext(false)
                    self.moreDataFlag = true
                }else{
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
        dataRequestTrigered(pageNum: 1)
    }
    
    func dataRequestTrigered(pageNum: Int){
        if moreDataFlag{
            dataRequestTrigered.onNext(pageNum)
        }
        
    }
    
    private func refreshViewControllerTableData() {
        viewReloadData.onNext(true)
    }
}
