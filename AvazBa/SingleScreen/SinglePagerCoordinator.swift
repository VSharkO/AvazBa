//
//  SingleCoordinator.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import UIKit

class SinglePagerCoordinator : Coordinator, CoordinatorDelegate, SingleCoordinatorDelegate{
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinatorDelegate: ParentCoordinatorDelegate?
    var presenter: UINavigationController
    private var controller: SinglePageViewController
    private var viewControllers = [SingleViewController]()
    
    init(presenter: UINavigationController, ids: [Int], focusedArticle: Int) {
        self.presenter = presenter
        for id in ids{
            let viewModel = SingleViewModel(repository: Repository(), id: id)
            let viewController = SingleViewController(viewModel: viewModel)
            viewControllers.append(viewController)
        }
        controller = SinglePageViewController(arrayOfViewControllers: viewControllers, focusedNews: focusedArticle)
    }
    
    func start() {
        presenter.pushViewController(controller, animated: true)
        controller.singleDelegate = self
        for controller in viewControllers{
            controller.singleCoordinatorDelegate = self
        }
    }
    
    func viewHasFinished() {
        childCoordinators.removeAll()
        parentCoordinatorDelegate?.childHasFinished(coordinator: self)
    }
    
    func openSingle(withId: Int) {
        let singleViewController = SingleViewController.init(viewModel: SingleViewModel.init(repository: Repository(), id: withId))
        singleViewController.singleCoordinatorDelegate = self
        presenter.pushViewController(singleViewController, animated: true)
    }
    
}
