//
//  UpperTitleCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 08/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class UpperTitleCell: UITableViewCell {

    let articleUpperTitle: UILabel = {
        let upperTitletext = UILabel()
        upperTitletext.translatesAutoresizingMaskIntoConstraints = false
        upperTitletext.adjustsFontSizeToFitWidth = false
        upperTitletext.numberOfLines = 1
        upperTitletext.font = UIFont.init(name: "Roboto-Bold", size: 14)
        upperTitletext.isUserInteractionEnabled = false
        return upperTitletext
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.contentView.addSubview(articleUpperTitle)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            articleUpperTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            articleUpperTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            articleUpperTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            articleUpperTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
        let articleTitleHeight = articleUpperTitle.heightAnchor.constraint(equalToConstant: 35)
        articleTitleHeight.priority = .init(999)
        articleTitleHeight.isActive = true
    }

}
