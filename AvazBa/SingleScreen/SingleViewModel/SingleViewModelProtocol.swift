//
//  SingleViewModelProtocol.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import RxSwift

protocol SingleViewModelProtocol{
    var data: SingleData{get}
    var viewReloadData: PublishSubject<Bool>{get}
    var viewShowLoader: PublishSubject<Bool>{get}
    func initGetingDataFromRepository() -> Disposable
    func getSpecificArticle()
}
