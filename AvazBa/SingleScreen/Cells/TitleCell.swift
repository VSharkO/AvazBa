//
//  TitleCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 08/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    let articleTitle: UILabel = {
        let titletext = UILabel()
        titletext.translatesAutoresizingMaskIntoConstraints = false
        titletext.adjustsFontSizeToFitWidth = false
        titletext.numberOfLines = 5
        titletext.font = UIFont.init(name: "RobotoSlab-Regular", size: 26)
        titletext.isUserInteractionEnabled = false
        return titletext
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
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            articleTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            articleTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            articleTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
    }


}
