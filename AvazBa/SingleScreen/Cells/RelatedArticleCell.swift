//
//  RelatedArticleCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 10/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//
import UIKit

class RelatedArticleCell : UITableViewCell{
    
    var relatedImage: UIImageView = {
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
    
    let relatedTitle: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.init(name: "RobotoSlab-Bold", size: 20)
        text.isScrollEnabled = false
        return text
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
    
    var publishedText : UILabel = {
        let publishedText = UILabel()
        publishedText.textColor = .darkGray
        publishedText.adjustsFontSizeToFitWidth = false
        publishedText.numberOfLines = 1
        publishedText.font = UIFont.init(name: "Roboto-Regular", size: 12)
        publishedText.isUserInteractionEnabled = false
        return publishedText
    }()
    
    var publishedImage : UIImageView = {
        let publishedImage = UIImageView()
        publishedImage.image = UIImage(named: "publishImg")
        return publishedImage
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
    
    var stackForPublished : UIStackView = {
        let stackForPublished = UIStackView()
        stackForPublished.translatesAutoresizingMaskIntoConstraints = false
        stackForPublished.spacing = 4
        stackForPublished.axis = .horizontal
        return stackForPublished
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
        self.contentView.addSubview(relatedImage)
        self.relatedImage.addSubview(categoryTextContainer)
        self.categoryTextContainer.addSubview(categoryText)
        self.contentView.addSubview(separator)
        self.contentView.addSubview(articleText)
        stackForPublished.addArrangedSubview(publishedImage)
        stackForPublished.addArrangedSubview(publishedText)
        self.contentView.addSubview(stackForPublished)
        stackForShares.addArrangedSubview(shareNumText)
        stackForShares.addArrangedSubview(shareImage)
        self.contentView.addSubview(stackForShares)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            relatedImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            relatedImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            relatedImage.widthAnchor.constraint(equalToConstant: 112),
            relatedImage.heightAnchor.constraint(equalToConstant: 112)
            ])
        
        NSLayoutConstraint.activate([
            categoryText.topAnchor.constraint(equalTo: categoryTextContainer.topAnchor),
            categoryText.bottomAnchor.constraint(equalTo: categoryTextContainer.bottomAnchor),
            categoryText.leadingAnchor.constraint(equalTo: categoryTextContainer.leadingAnchor, constant: 7),
            categoryText.trailingAnchor.constraint(equalTo: categoryTextContainer.trailingAnchor, constant: -7)
            ])
        
        NSLayoutConstraint.activate([
            categoryTextContainer.bottomAnchor.constraint(equalTo: relatedImage.bottomAnchor, constant: -8),
            categoryTextContainer.leadingAnchor.constraint(equalTo: relatedImage.leadingAnchor, constant: 8),
            categoryTextContainer.trailingAnchor.constraint(lessThanOrEqualTo: relatedImage.trailingAnchor, constant: -8),
            categoryTextContainer.heightAnchor.constraint(equalToConstant: 21)
            ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: self.relatedImage.bottomAnchor, constant: 8),
            separator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            separator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            articleText.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            articleText.leadingAnchor.constraint(equalTo: self.relatedImage.trailingAnchor, constant: 16),
            articleText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            articleText.heightAnchor.constraint(lessThanOrEqualToConstant: 76)
            ])
        
        let articleSeparatorHeight = separator.heightAnchor.constraint(equalToConstant: 1)
        articleSeparatorHeight.priority = .init(999)
        articleSeparatorHeight.isActive = true
        
        NSLayoutConstraint.activate([
            stackForPublished.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -16),
            stackForPublished.leadingAnchor.constraint(equalTo: relatedImage.trailingAnchor, constant: 16)
            ])
        
        NSLayoutConstraint.activate([
            stackForShares.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -16),
            stackForShares.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -31)
            ])
        
    }
    
    func setImage(image: String){
        let url = URL(string: constants.baseUrl + image)
        relatedImage.kf.setImage(with:url)
    }
}
