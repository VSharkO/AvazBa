//
//  loaderCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 21/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class LoaderCell : UITableViewCell{
    var refreshController: UIRefreshControl?
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.startAnimating()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setupViews(){
        self.addSubview(loader)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            loader.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
    }
}
