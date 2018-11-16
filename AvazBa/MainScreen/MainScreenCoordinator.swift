//
//  MainScreenCoordinator.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import UIKit

class MainScreenCoordinator : Coordinator, CoordinatorDelegate{
    
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
//    private var controller: MainViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
//        controller = MainViewController(viewModel: MainViewModel())
    }
    
    func start() {
//        presenter.pushViewController(controller, animated: true)
    }
    
    func viewHasFinished() {
        childCoordinators.removeAll()
    }
    
}
