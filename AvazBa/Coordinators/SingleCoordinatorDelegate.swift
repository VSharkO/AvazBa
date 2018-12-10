//
//  SingleCoordinatorDelegate.swift
//  AvazBa
//
//  Created by Valentin Šarić on 10/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

protocol SingleCoordinatorDelegate: CoordinatorDelegate {
    func openSingle(withId: Int)
}
