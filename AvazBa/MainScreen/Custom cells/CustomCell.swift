//
//  CustomCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 18/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    var rootView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        return view
    }()

    var articlePhoto : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "image1")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 7
        image.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return image
    }()
    
    var articleTitle : UILabel = {
        let articleTitle = UILabel()
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        articleTitle.textColor = .darkGray
        articleTitle.adjustsFontSizeToFitWidth = false
        articleTitle.numberOfLines = 2
        articleTitle.font = UIFont.init(name: "RobotoSlab-Bold", size: 14)
        articleTitle.text = "SAmo sadas ldkfgsm lksdmfg lksmdflg mslSAmo sadas ldkfgsm lksdmfg lksmdflg msldkfgmlk smdfgml lksdmfg lksmdflg msldkfgmlk smdfgml dfgdfg"
        articleTitle.isUserInteractionEnabled = false
        return articleTitle
    }()
    
    var articleText : UILabel = {
        let articleText = UILabel()
        articleText.translatesAutoresizingMaskIntoConstraints = false
        articleText.textColor = .darkGray
        articleText.adjustsFontSizeToFitWidth = false
        articleText.numberOfLines = 2
        articleText.font = UIFont.init(name: "Lato-Regular", size: 13)
        articleText.text = "SAmo sadas ldkfgsm lksdmfg lksmdflg mslSAmo sadas ldkfgsm lksdmfg lksmdflg msldkfgmlk smdfgml lksdmfg lksmdflg msldkfgmlk smdfgml dfgdfg"
        articleText.isUserInteractionEnabled = false
        return articleText
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.contentView.addSubview(rootView)
        self.rootView.addSubview(articlePhoto)
        self.rootView.addSubview(articleTitle)
        self.rootView.addSubview(articleText)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            rootView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            rootView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            rootView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
            ])
        let constraintRootViewHeight = rootView.heightAnchor.constraint(equalToConstant: 338)
        constraintRootViewHeight.priority = .init(999)
        constraintRootViewHeight.isActive = true
        
        NSLayoutConstraint.activate([
            articlePhoto.topAnchor.constraint(equalTo: rootView.topAnchor),
            articlePhoto.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            articlePhoto.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            articlePhoto.heightAnchor.constraint(equalToConstant: 217)
            ])
        
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: articlePhoto.bottomAnchor, constant: 8),
            articleTitle.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 16.7),
            articleTitle.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -50)
            ])
        
        NSLayoutConstraint.activate([
            articleText.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 5),
            articleText.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 16.7),
            articleText.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -50),
            articleText.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
}
