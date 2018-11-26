//
//  ViewController.swift
//  AvazBa
//
//  Created by Valentin Šarić on 26/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTabs

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = MDCTabBar(frame: view.bounds)
        tabBar.items = [
            UITabBarItem(title: "Recents", image: UIImage(named: "phone"), tag: 0),
            UITabBarItem(title: "Favorites", image: UIImage(named: "heart"), tag: 0),
        ]
        tabBar.itemAppearance = .titledImages
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        view.addSubview(tabBar)
    }

}
