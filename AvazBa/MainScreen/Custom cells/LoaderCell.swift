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
    
    var rootView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        return view
    }()
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.color = .black
        loader.startAnimating()
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
        contentView.addSubview(rootView)
        rootView.addSubview(loader)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            rootView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            rootView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            rootView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
            ])
        let constraintRootViewHeight = rootView.heightAnchor.constraint(equalToConstant: 40)
        constraintRootViewHeight.priority = .init(999)
        constraintRootViewHeight.isActive = true
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: self.rootView.topAnchor),
            loader.leadingAnchor.constraint(equalTo: self.rootView.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: self.rootView.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: self.rootView.bottomAnchor),
            loader.centerXAnchor.constraint(equalTo: self.rootView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: self.rootView.centerYAnchor)
            ])
    }
}
