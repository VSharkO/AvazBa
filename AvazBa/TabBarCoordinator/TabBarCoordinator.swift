//
//  TabBarCoordinator.swift
//  AvazBa
//
//  Created by Valentin Šarić on 26/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTabs

class TabBarCoordinator :Coordinator{
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    private var controller: MDCTabBarViewController
    var mainCoordinator: Coordinator!
    var favoritesCoordinator: Coordinator!
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        presenter.isNavigationBarHidden = true
        
        mainCoordinator = MainScreenCoordinator(presenter: UINavigationController())
        controller = MCDViewController(viewControllers: [mainCoordinator.presenter])
        controller.navigationItem.title = "Factory"
//        favoritesCoordinator = FavoritesCoordinator(presenter: UINavigationController())
        
//        mainCoordinator.presenter.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//        mainCoordinator.presenter.navigationItem.title = "Articles"
//        mainCoordinator.presenter.isNavigationBarHidden = false
//        favoritesCoordinator.presenter.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//        favoritesCoordinator.presenter.navigationItem.title = "Favorites"
        
//        self.controller. ([mainCoordinator.presenter/*,favoritesCoordinator.presenter*/],animated: false)
    }
    
    func start() {
        mainCoordinator.start()
//        favoritesCoordinator.start()
        presenter.pushViewController(controller, animated: true)
        
    }
    
    func viewHasFinished() {
        childCoordinators.removeAll()
    }

}

