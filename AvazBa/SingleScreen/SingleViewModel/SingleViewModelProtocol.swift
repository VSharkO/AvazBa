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
    func initGetingDataFromRepository() -> Disposable
    func getSpecificArticle()
    func getData() -> [(data: String,typeOfCell: String)]
}
