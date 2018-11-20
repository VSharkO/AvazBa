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
    
    let repository: RepositoryProtocol!
    var dataRequestTrigered = PublishSubject<Int>()
    var viewShowLoader = PublishSubject<Bool>()
    var viewReloadData = PublishSubject<Bool>()
    var pullToRefreshTrigered = PublishSubject<Bool>()
    var pulltoRefreshFlag = false
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func initGetingDataFromRepository() -> Disposable {
        return dataRequestTrigered.flatMap({ [unowned self] num -> Observable<[Article]> in
            if !self.pulltoRefreshFlag{self.viewShowLoader.onNext(true)}
            return self.repository.getMostPopularArticles(pageNum: num)
        })
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] articles in
            self.data = articles
            self.refreshViewModelData()
            self.viewShowLoader.onNext(false)
            self.pulltoRefreshFlag = false
        })
    }
    
    func initPullToRefreshHandler() -> Disposable{
        return pullToRefreshTrigered.subscribe(onNext: { [unowned self] _ in
            self.dataRequestTrigered(pageNum: 1)
        })
    }
    
    private func refreshViewModelData() {
        viewReloadData.onNext(true)
    }
    
    func getData() -> [Article]{
        return data
    }
    
    func pullToRefresh(){
        pulltoRefreshFlag = true
        pullToRefreshTrigered.onNext(true)
    }
    
    func dataRequestTrigered(pageNum: Int){
        dataRequestTrigered.onNext(pageNum)
    }
}
