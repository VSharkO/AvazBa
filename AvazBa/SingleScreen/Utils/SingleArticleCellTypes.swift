//
//  SingleArticleCellTypes.swift
//  AvazBa
//
//  Created by Valentin Šarić on 07/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

import Foundation

enum SingleArticleCellTypes {
    case title
    case upperTitle
    case text
    case image
    case relatedNews
    case mostReadNews
    case titleRow
    case publishedCell
    case noCell
}

protocol CellProtocol{
    var cellType: SingleArticleCellTypes{get}
    var data: Any?{get}
}

struct Cell: CellProtocol{
    var cellType: SingleArticleCellTypes
    var data: Any?
}
