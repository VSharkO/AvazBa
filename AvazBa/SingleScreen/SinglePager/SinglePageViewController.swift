//
//  SinglePageViewController.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class SinglePageViewController: UIPageViewController {

    weak var singleDelegate: CoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    init(arrayOfViewControllers: [SingleViewController], focusedNews: Int) {
        super.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        self.setViewControllers([arrayOfViewControllers[focusedNews]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if(isMovingFromParentViewController){
            singleDelegate?.viewHasFinished()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let listOfViewControllers = self.viewControllers{
            if let viewControllerIndex = listOfViewControllers.index(of: viewController){
                if viewControllerIndex == 0 {
                    // wrap to last page in array
                    return self.viewControllers?.last
                } else {
                    // go to previous page in array
                    return listOfViewControllers[viewControllerIndex - 1]
                }
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
            if let listOfViewControllers = self.viewControllers{
                if let viewControllerIndex = listOfViewControllers.index(of: viewController){
                    if viewControllerIndex < listOfViewControllers.count - 1 {
                        // wrap to last page in array
                        return listOfViewControllers[viewControllerIndex - 1]
                    } else {
                        // go to previous page in array
                        return listOfViewControllers.first
                    }
                }
            }
        return nil
    }

}
