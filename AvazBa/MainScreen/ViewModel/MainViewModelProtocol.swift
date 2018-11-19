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
    func refreshViewModelData()
    func getData() -> [Article]
    func dataRequestTrigered(pageNum: Int)
    
    var viewReloadData: PublishSubject<Bool>{get set}
    var showSpinner: PublishSubject<Bool>{get set}
}
