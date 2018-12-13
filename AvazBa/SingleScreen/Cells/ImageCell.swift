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
        categoryText.textAlignment = .center
        return categoryText
    }()
    
    var sourceText : UILabel = {
        let sourceText = UILabel()
        sourceText.translatesAutoresizingMaskIntoConstraints = false
        sourceText.textColor = .white
        sourceText.adjustsFontSizeToFitWidth = false
        sourceText.numberOfLines = 1
        sourceText.font = UIFont.init(name: "Roboto-Regular", size: 12)
        sourceText.isUserInteractionEnabled = false
        sourceText.backgroundColor = .clear
        sourceText.textAlignment = .left
        return sourceText
    }()
    
    var descriptionText : UILabel = {
        let descriptionText = UILabel()
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.textColor = .white
        descriptionText.adjustsFontSizeToFitWidth = false
        descriptionText.numberOfLines = 3
        descriptionText.font = UIFont.init(name: "Roboto-Regular", size: 12)
        descriptionText.isUserInteractionEnabled = false
        descriptionText.backgroundColor = .clear
        descriptionText.text = "dasdasdasd dasda "
        descriptionText.textAlignment = .left
        return descriptionText
    }()
    
    var categoryTextContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .red
        container.layer.cornerRadius = 3
        container.layer.masksToBounds = true
        return container
    }()
    
    var bookmarksImage: UIImageView = {
        let bookmarksImage = UIImageView()
        bookmarksImage.translatesAutoresizingMaskIntoConstraints = false
        bookmarksImage.image = UIImage(named: "bookmarkImg")
        return bookmarksImage
    }()
    
    var bookmarkImageContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    var stackViewForCategory: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.axis = .horizontal
        return stackView
    }()
    
    var stackViewForAll: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    override func prepareForReuse() {
        self.stackViewForAll.removeArrangedSubview(sourceText)
        self.stackViewForAll.removeArrangedSubview(descriptionText)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.contentView.addSubview(articleImage)
        self.categoryTextContainer.addSubview(categoryText)
        self.stackViewForCategory.addArrangedSubview(categoryTextContainer)
        self.bookmarkImageContainer.addSubview(bookmarksImage)
        self.stackViewForCategory.addArrangedSubview(bookmarkImageContainer)
        self.stackViewForAll.addArrangedSubview(stackViewForCategory)
        self.articleImage.addSubview(stackViewForAll)
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
        
        NSLayoutConstraint.activate([
            categoryText.topAnchor.constraint(equalTo: self.categoryTextContainer.topAnchor),
            categoryText.leadingAnchor.constraint(equalTo: self.categoryTextContainer.leadingAnchor, constant: 6),
            categoryText.trailingAnchor.constraint(equalTo: self.categoryTextContainer.trailingAnchor, constant: -5),
            categoryText.bottomAnchor.constraint(equalTo: self.categoryTextContainer.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            categoryTextContainer.heightAnchor.constraint(equalToConstant: 22)
            ])
        
        NSLayoutConstraint.activate([
            bookmarksImage.topAnchor.constraint(equalTo: self.bookmarkImageContainer.topAnchor, constant: 2),
            bookmarksImage.bottomAnchor.constraint(equalTo: self.bookmarkImageContainer.bottomAnchor, constant: -2),
            bookmarksImage.leadingAnchor.constraint(equalTo: self.bookmarkImageContainer.leadingAnchor, constant: 3),
            bookmarksImage.trailingAnchor.constraint(equalTo: self.bookmarkImageContainer.trailingAnchor, constant: 3)
            ])
        
        NSLayoutConstraint.activate([
            stackViewForAll.leadingAnchor.constraint(equalTo: self.articleImage.leadingAnchor, constant: 16),
            stackViewForAll.trailingAnchor.constraint(lessThanOrEqualTo: self.articleImage.trailingAnchor, constant: -50),
            stackViewForAll.bottomAnchor.constraint(equalTo: self.articleImage.bottomAnchor, constant: -16)
            ])
    }
    
    func setImage(image: String){
        let url = URL(string: constants.baseUrl + image)
        articleImage.kf.setImage(with:url)
    }

    
    func setupImageDescription(description: String?){
        if let description = description{
            if !description.isEmpty{
                self.descriptionText.text = description
                self.stackViewForAll.addArrangedSubview(descriptionText)
            }
        }
    }
    
    func setupImageSource(description: String?){
        if let description = description{
            if !description.isEmpty{
                self.sourceText.text = "Source: " +  description
                self.stackViewForAll.addArrangedSubview(sourceText)
            }
        }
    }
}
