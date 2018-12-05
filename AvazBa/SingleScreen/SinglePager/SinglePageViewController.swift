//
//  SinglePageViewController.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class SinglePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    weak var singleDelegate: CoordinatorDelegate?
    var pages = [UIViewController]()
    var focusedItem = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        setViewControllers([pages[focusedItem]],direction: .forward , animated: true, completion: nil)
    }
    
    init(arrayOfViewControllers: [SingleViewController], focusedNews: Int) {
        super.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        self.pages = arrayOfViewControllers
        self.focusedItem = focusedNews
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
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.pages.last
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
    }
}
