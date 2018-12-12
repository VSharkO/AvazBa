//
//  TextCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 09/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    let articleText: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.init(name: "Roboto-Regular", size: 14)
        text.textColor = .gray
        text.isScrollEnabled = false
        return text
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.contentView.addSubview(articleText)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            articleText.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            articleText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            articleText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            articleText.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
    }
    
}
