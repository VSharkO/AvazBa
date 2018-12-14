//
//  Utils.swift
//  AvazBa
//
//  Created by Valentin Šarić on 19/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

struct Constants{
    static let baseUrl = "http://api.avaz.ba/"
    static let api = "api/"
    static let article = "clanak/"
    static let num = "/1"
    static let apiToken = "?api_token=bXd5Dvw1MGZlb9LrNsmDSA6Nv5Gz21oD4SgEOo4QPs0Nv3VAHYFa6oquDdJe"
    static let pageNumber = "&stranica="
    static let newest = "Najnovije"
    static let mostRead = "Najčitanije"
    static let newestApi = "najnovije"
    static let mostReadApi = "najcitanije"
    static let text = "text"
    static let related = "Povezano"
    static let published = "Objavljeno:  "
}

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

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
