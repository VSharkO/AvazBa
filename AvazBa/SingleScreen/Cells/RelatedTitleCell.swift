//
//  RelatedTitleCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 10/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class RelatedTitleCell : UITableViewCell{
    
    let relatedTitle: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.init(name: "RobotoSlab-Bold", size: 20)
        text.isScrollEnabled = false
        return text
    }()
    
    let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(red:0.93, green:0, blue:0, alpha:1)
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
        self.contentView.addSubview(relatedTitle)
        self.contentView.addSubview(separator)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            relatedTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            relatedTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            relatedTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
            ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: self.relatedTitle.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            separator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
        let articleSeparatorHeight = separator.heightAnchor.constraint(equalToConstant: 3)
        articleSeparatorHeight.priority = .init(999)
        articleSeparatorHeight.isActive = true
    }
    
}
