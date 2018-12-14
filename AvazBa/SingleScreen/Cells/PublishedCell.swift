//
//  publishedCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 13/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class PublishedCell : UITableViewCell{
    
    var publishedDateText : UILabel = {
        let categoryText = UILabel()
        categoryText.translatesAutoresizingMaskIntoConstraints = false
        categoryText.textColor = .black
        categoryText.alpha = 0.6
        categoryText.adjustsFontSizeToFitWidth = false
        categoryText.numberOfLines = 1
        categoryText.font = UIFont.init(name: "Roboto-Regular", size: 12)
        categoryText.isUserInteractionEnabled = false
        categoryText.backgroundColor = .clear
        categoryText.textAlignment = .center
        return categoryText
    }()
    
    let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
        return separator
    }()
    
    var dot : UIView = {
        let dot = UIView()
        dot.translatesAutoresizingMaskIntoConstraints = false
        let dotPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 5, width: 4, height: 4), cornerRadius: 4)
        let layer = CAShapeLayer()
        layer.path = dotPath.cgPath
        dot.alpha = 0.2
        dot.layer.addSublayer(layer)
        return dot
    }()
    
    var publishedBeforeText : UILabel = {
        let sourceText = UILabel()
        sourceText.translatesAutoresizingMaskIntoConstraints = false
        sourceText.textColor = .black
        sourceText.alpha = 0.6
        sourceText.adjustsFontSizeToFitWidth = false
        sourceText.numberOfLines = 1
        sourceText.font = UIFont.init(name: "Roboto-Regular", size: 12)
        sourceText.isUserInteractionEnabled = false
        sourceText.backgroundColor = .clear
        sourceText.textAlignment = .center
        return sourceText
    }()
    
    var authorText : UILabel = {
        let publishedText = UILabel()
        publishedText.textColor = .black
        publishedText.alpha = 0.6
        publishedText.adjustsFontSizeToFitWidth = false
        publishedText.numberOfLines = 1
        publishedText.font = UIFont.init(name: "Roboto-Regular", size: 12)
        publishedText.isUserInteractionEnabled = false
        return publishedText
    }()
    
    var authorImage : UIImageView = {
        let authorImage = UIImageView()
        authorImage.image = UIImage(named: "authorImg")
        return authorImage
    }()
    
    var publishedImage : UIImageView = {
        let publishedImage = UIImageView()
        publishedImage.image = UIImage(named: "publishImg")
        return publishedImage
    }()
    
    var shareNumText : UILabel = {
        let shareNumText = UILabel()
        shareNumText.textColor = .black
        shareNumText.alpha = 0.6
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
    
    var stackForAuthor : UIStackView = {
        let stackForPublished = UIStackView()
        stackForPublished.translatesAutoresizingMaskIntoConstraints = false
        stackForPublished.spacing = 8
        stackForPublished.axis = .horizontal
        return stackForPublished
    }()
    
    var stackForShares : UIStackView = {
        let stackForShares = UIStackView()
        stackForShares.translatesAutoresizingMaskIntoConstraints = false
        stackForShares.spacing = 8
        stackForShares.axis = .horizontal
        return stackForShares
    }()
    
    var stackViewForAll: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        stackViewForAll.addArrangedSubview(publishedImage)
        stackViewForAll.addArrangedSubview(publishedDateText)
        stackViewForAll.addArrangedSubview(dot)
        stackViewForAll.addArrangedSubview(publishedBeforeText)
        stackForShares.addArrangedSubview(shareNumText)
        stackForShares.addArrangedSubview(shareImage)
        stackForAuthor.addArrangedSubview(authorImage)
        stackForAuthor.addArrangedSubview(authorText)
        self.contentView.addSubview(stackForAuthor)
        self.contentView.addSubview(stackForShares)
        self.contentView.addSubview(stackViewForAll)
        self.contentView.addSubview(separator)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            stackViewForAll.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            stackViewForAll.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            stackViewForAll.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            stackForAuthor.topAnchor.constraint(equalTo: self.stackViewForAll.bottomAnchor, constant: 8),
            stackForAuthor.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
            ])
        
        NSLayoutConstraint.activate([
            stackForShares.topAnchor.constraint(equalTo: self.stackViewForAll.bottomAnchor, constant: 8),
            stackForShares.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
            ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: self.stackForAuthor.bottomAnchor, constant: 16),
            separator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            separator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
        let articleSeparatorHeight = separator.heightAnchor.constraint(equalToConstant: 1)
        articleSeparatorHeight.priority = .init(999)
        articleSeparatorHeight.isActive = true
        
    }
    
}
