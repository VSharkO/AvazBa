//
//  MCDViewController.swift
//  AvazBa
//
//  Created by Valentin Šarić on 27/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTabs

class MCDViewController: MDCTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
