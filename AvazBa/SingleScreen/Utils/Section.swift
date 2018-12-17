//
//  Section.swift
//  AvazBa
//
//  Created by Valentin Šarić on 17/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

enum SectionType{
    case article
    case related
    case mostRead
}

struct Section{
    let sectionType: SectionType
    var data: [Cell]
}
