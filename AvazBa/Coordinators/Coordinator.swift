//
//  Coordinator.swift
//  NewsApp
//
//  Created by Valentin Šarić on 06/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import UIKit

public protocol Coordinator: class {
    var childCoordinators: [Coordinator] {get set}
    var presenter: UINavigationController {get set}
    func start ()
}

public extension Coordinator {
    func addChildCoordinator(childCoordinator: Coordinator){
        self.childCoordinators.append(childCoordinator)
    }
    func removeChildCoordinator(childCoordinator: Coordinator){
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
}
