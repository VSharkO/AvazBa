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
    
    func initGetingDataFromRepository() -> Disposable {
        return Observable.just(0).subscribe() //ovo implementirati
    }
    
    func refreshData() {
        
    }
    
    let repository: RepositoryProtocol!
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
}
