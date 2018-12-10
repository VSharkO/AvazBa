//
//  MostPopularArticleCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 10/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class MostReadArticleCell : UITableViewCell{
    
    var mostReadImage: UIImageView = {
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
    
    let articleText: UILabel = {
        let titletext = UILabel()
        titletext.translatesAutoresizingMaskIntoConstraints = false
        titletext.adjustsFontSizeToFitWidth = false
        titletext.numberOfLines = 4
        titletext.font = UIFont.init(name: "Roboto-Bold", size: 14)
        titletext.isUserInteractionEnabled = false
        return titletext
    }()
    
    var shareNumText : UILabel = {
        let shareNumText = UILabel()
        shareNumText.textColor = .darkGray
        shareNumText.adjustsFontSizeToFitWidth = false
        shareNumText.numberOfLines = 1
        shareNumText.font = UIFont.init(name: "Roboto-Regular", size: 12)
        shareNumText.isUserInteractionEnabled = false
        return shareNumText
    }()
    
    var shareImage : UIImageView = {
        let shareImage = UIImageView()
        shareImage.image = UIImage(named: "shareImg")
        return shareImage
    }()
    
    var stackForShares : UIStackView = {
        let stackForShares = UIStackView()
        stackForShares.translatesAutoresizingMaskIntoConstraints = false
        stackForShares.spacing = 4
        stackForShares.axis = .horizontal
        return stackForShares
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
        self.contentView.addSubview(mostReadImage)
        self.contentView.addSubview(categoryTextContainer)
        self.categoryTextContainer.addSubview(categoryText)
        self.contentView.addSubview(separator)
        self.contentView.addSubview(articleText)
        stackForShares.addArrangedSubview(shareNumText)
        stackForShares.addArrangedSubview(shareImage)
        self.contentView.addSubview(stackForShares)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            mostReadImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            mostReadImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            mostReadImage.widthAnchor.constraint(equalToConstant: 125),
            mostReadImage.heightAnchor.constraint(equalToConstant: 112)
            ])
        
        NSLayoutConstraint.activate([
            categoryText.topAnchor.constraint(equalTo: categoryTextContainer.topAnchor),
            categoryText.bottomAnchor.constraint(equalTo: categoryTextContainer.bottomAnchor),
            categoryText.leadingAnchor.constraint(equalTo: categoryTextContainer.leadingAnchor, constant: 7),
            categoryText.trailingAnchor.constraint(equalTo: categoryTextContainer.trailingAnchor, constant: -7)
            ])
        
        NSLayoutConstraint.activate([
            categoryTextContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            categoryTextContainer.leadingAnchor.constraint(equalTo: mostReadImage.trailingAnchor, constant: 16),
            categoryTextContainer.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            categoryTextContainer.heightAnchor.constraint(equalToConstant: 21)
            ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: self.mostReadImage.bottomAnchor, constant: 8),
            separator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            separator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            articleText.topAnchor.constraint(equalTo: self.categoryTextContainer.topAnchor, constant: 11),
            articleText.leadingAnchor.constraint(equalTo: self.mostReadImage.trailingAnchor, constant: 16),
            articleText.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            articleText.heightAnchor.constraint(lessThanOrEqualToConstant: 76)
            ])
        
        let articleSeparatorHeight = separator.heightAnchor.constraint(equalToConstant: 1)
        articleSeparatorHeight.priority = .init(999)
        articleSeparatorHeight.isActive = true
        
        NSLayoutConstraint.activate([
            stackForShares.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -16),
            stackForShares.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
            ])
        
    }
    
    func setImage(image: String){
        let url = URL(string: constants.baseUrl + image)
        mostReadImage.kf.setImage(with:url)
    }
}
