//
//  DataFormatter.swift
//  AvazBa
//
//  Created by Valentin Šarić on 17/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

struct ArticleDateFormatter{
    static func getFormater() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.000000"
        return formatter
    }
}
