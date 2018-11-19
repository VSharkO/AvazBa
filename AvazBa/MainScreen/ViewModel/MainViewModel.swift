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
    var showSpinner = PublishSubject<Bool>()
    
    var viewReloadData = PublishSubject<Bool>()
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func initGetingDataFromRepository() -> Disposable {
        return dataRequestTrigered.flatMap({ num -> Observable<[Article]> in
            self.showSpinner.onNext(true)
            return self.repository.getMostPopularArticles(pageNum: num)
        }).subscribe(onNext: { [unowned self] articles in
            self.data = articles
            self.refreshViewModelData()
            self.showSpinner.onNext(false)
        })
    }
    
    func refreshViewModelData() {
        viewReloadData.onNext(true)
    }
    
    func getData() -> [Article]{
        return data
    }
    
    func dataRequestTrigered(pageNum: Int){
        dataRequestTrigered.onNext(pageNum)
    }
}
