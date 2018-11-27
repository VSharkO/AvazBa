//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Valentin Šarić on 06/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow?){
        presenter = UINavigationController()
        window?.rootViewController = presenter
    }
    
    func start() {
        let mainCoordinator = MainScreenCoordinator(presenter: presenter)
        mainCoordinator.start()
        self.addChildCoordinator(childCoordinator: mainCoordinator)
    }
}
