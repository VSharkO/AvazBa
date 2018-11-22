//
//  CellTypes.swift
//  AvazBa
//
//  Created by Valentin Šarić on 22/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

enum CellType {
    case article
    case loader
}

protocol CellItem{
    var cellType: CellType{get}
}

struct LoaderCellType: CellItem{
    var cellType: CellType = .loader
}
