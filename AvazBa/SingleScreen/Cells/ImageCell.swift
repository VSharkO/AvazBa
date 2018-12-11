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
    
    var categoryText : UILabel = {
        let categoryText = UILabel()
        categoryText.translatesAutoresizingMaskIntoConstraints = false
        categoryText.textColor = .white
        categoryText.adjustsFontSizeToFitWidth = false
        categoryText.numberOfLines = 1
        categoryText.font = UIFont.init(name: "Roboto-Regular", size: 12)
        categoryText.isUserInteractionEnabled = false
        categoryText.backgroundColor = .clear
        categoryText.textAlignment = .justified
        return categoryText
    }()
    
    var categoryTextContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .red
        container.layer.cornerRadius = 3
        container.layer.masksToBounds = true
        return container
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
                articleImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
               
            ])
        let articleImageHeight = articleImage.heightAnchor.constraint(equalToConstant: 286)
        articleImageHeight.priority = .init(999)
        articleImageHeight.isActive = true
    }
    
    func setImage(image: String){
        let url = URL(string: constants.baseUrl + image)
        articleImage.kf.setImage(with:url)
    }
}
