//
//  SingleCellTypes.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

enum TypeOfSingleCell {
    case image
    case title
}

protocol SingleCellType{
    var cellType: TypeOfSingleCell{get}
}

struct SingleTitleCell: SingleCellType{
    var cellType: TypeOfSingleCell = .title
}

struct SingleImageCell: SingleCellType{
    var cellType: TypeOfSingleCell = .image
}
