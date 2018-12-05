//
//  SingleCoordinator.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import UIKit

class SingleCoordinator : Coordinator, CoordinatorDelegate{
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinatorDelegate: ParentCoordinatorDelegate?
    var presenter: UINavigationController
    private var controller: SinglePageViewController
    
    init(presenter: UINavigationController, ids: [Int], focusedArticle: Int) {
        self.presenter = presenter
        var viewControllers = [SingleViewController]()
        for id in ids{
            let viewModel = SingleViewModel.init(id: id)
            viewControllers.append(SingleViewController(viewModel: viewModel))
        }
        controller = SinglePageViewController(arrayOfViewControllers: viewControllers, focusedNews: focusedArticle)
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
    
    func viewHasFinished() {
        childCoordinators.removeAll()

    }
    
    
}
