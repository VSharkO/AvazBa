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
    func moreDataRequest()
    func pullToRefresh()
    
    var data: [CellItem]{get}
    var selectedTab: String{get set}
    var viewShowLoader: PublishSubject<Bool>{get set}
    var viewReloadData: PublishSubject<Bool>{get set}
    var viewInsertRows: PublishSubject<[IndexPath]>{get set}
    var viewReloadRows: PublishSubject<[IndexPath]>{get set}
}
