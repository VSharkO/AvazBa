//
//  CoordinatorDelegate.swift
//  NewsApp
//
//  Created by Valentin Šarić on 06/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

protocol CoordinatorDelegate: class {
    func viewHasFinished()
}

protocol ParentCoordinatorDelegate: class {
    func childHasFinished(coordinator: Coordinator)
}
