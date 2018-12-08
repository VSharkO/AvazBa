//
//  TitleCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 08/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    let articleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.contentView.addSubview(articleImage)
        
        setupConstraints()
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
                articleImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                articleImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                articleImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                articleImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                articleImage.heightAnchor.constraint(equalToConstant: 286)
            ])
    }
    
    func setImage(image: String){
        let url = URL(string: constants.baseUrl + image)
        articleImage.kf.setImage(with:url)
    }
}
