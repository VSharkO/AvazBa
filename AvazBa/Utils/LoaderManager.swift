//
//  Loader.swift
//  AvazBa
//
//  Created by Valentin Šarić on 17/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
protocol LoaderManager{
    func displayLoader(onView : UIView) -> UIView
    func removeLoader(loader :UIView)
}

extension LoaderManager {
    func displayLoader(onView : UIView) -> UIView {
        let loaderView = UIView.init(frame: onView.bounds)
        loaderView.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.9)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = loaderView.center
        
        DispatchQueue.main.async {
            loaderView.addSubview(ai)
            onView.addSubview(loaderView)
        }
        
        return loaderView
    }
    
    func removeLoader(loader: UIView) {
        DispatchQueue.main.async {
            loader.removeFromSuperview()
        }
    }
}
