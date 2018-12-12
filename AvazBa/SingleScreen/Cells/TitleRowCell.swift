//
//  TitleRowCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 11/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class TitleRowCell : UITableViewCell{
    
    let articleTitle: UILabel = {
        let titletext = UILabel()
        titletext.translatesAutoresizingMaskIntoConstraints = false
        titletext.adjustsFontSizeToFitWidth = false
        titletext.numberOfLines = 5
        titletext.font = UIFont.init(name: "Roboto-Regular", size: 14)
        titletext.textColor = UIColor(red:0, green:0, blue:0, alpha:0.6)
        titletext.isUserInteractionEnabled = false
        return titletext
    }()
    
    let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
        return separator
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.contentView.addSubview(articleTitle)
        self.contentView.addSubview(separator)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            articleTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            articleTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
            ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: self.articleTitle.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            separator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
        let articleSeparatorHeight = separator.heightAnchor.constraint(equalToConstant: 1)
        articleSeparatorHeight.priority = .init(999)
        articleSeparatorHeight.isActive = true
    }
    
    
}
