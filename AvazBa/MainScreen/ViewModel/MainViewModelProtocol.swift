//
//  MainViewModelProtocol.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift

protocol MainViewModelProtocol{
    func initGetingDataFromRepository() -> Disposable
    func getData() -> [Article]
    func moreDataRequest()
    func initPullToRefreshHandler() -> Disposable
    func pullToRefresh()
    
    var viewShowLoader: PublishSubject<Bool>{get set}
    var viewReloadData: PublishSubject<Bool>{get set}
}
