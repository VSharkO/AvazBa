//
//  CustomCell.swift
//  AvazBa
//
//  Created by Valentin Šarić on 18/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    var rootView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 1
        return view
    }()

    var articlePhoto : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 7
        image.contentMode = .scaleAspectFill
        image.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return image
    }()
    
    var articleTitle : UILabel = {
        let articleTitle = UILabel()
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        articleTitle.textColor = .darkGray
        articleTitle.adjustsFontSizeToFitWidth = false
        articleTitle.numberOfLines = 2
        articleTitle.font = UIFont.init(name: "RobotoSlab-Bold", size: 14)
        articleTitle.isUserInteractionEnabled = false
        return articleTitle
    }()
    
    var articleText : UILabel = {
        let articleText = UILabel()
        articleText.translatesAutoresizingMaskIntoConstraints = false
        articleText.textColor = .darkGray
        articleText.adjustsFontSizeToFitWidth = false
        articleText.numberOfLines = 2
        articleText.font = UIFont.init(name: "Lato-Regular", size: 13)
        articleText.isUserInteractionEnabled = false
        return articleText
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
    
    var galleryImage : UIImageView = {
        let galleryImage = UIImageView()
        galleryImage.translatesAutoresizingMaskIntoConstraints = false
        galleryImage.image = UIImage(named: "cameraImg")
        return galleryImage
    }()
    
    var galleryImageContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .red
        container.layer.cornerRadius = 3
        container.layer.masksToBounds = true
        return container
    }()
    
    var videoImage : UIImageView = {
        let galleryImage = UIImageView()
        galleryImage.translatesAutoresizingMaskIntoConstraints = false
        galleryImage.image = UIImage(named: "playImg")
        return galleryImage
    }()
    
    var videoImageContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .red
        container.layer.cornerRadius = 3
        container.layer.masksToBounds = true
        return container
    }()
    
    var stackForCategory : UIStackView = {
        let stackForCategory = UIStackView()
        stackForCategory.translatesAutoresizingMaskIntoConstraints = false
        stackForCategory.spacing = -5
        stackForCategory.axis = .horizontal
        return stackForCategory
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.contentView.addSubview(rootView)
        self.rootView.addSubview(articlePhoto)
        self.rootView.addSubview(articleTitle)
        self.rootView.addSubview(articleText)
        stackForPublished.addArrangedSubview(publishedImage)
        stackForPublished.addArrangedSubview(publishedText)
        self.rootView.addSubview(stackForPublished)
        stackForShares.addArrangedSubview(shareNumText)
        stackForShares.addArrangedSubview(shareImage)
        self.rootView.addSubview(stackForShares)
        articlePhoto.addSubview(stackForCategory)
        self.categoryTextContainer.addSubview(categoryText)
        self.stackForCategory.addArrangedSubview(categoryTextContainer)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            rootView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            rootView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            rootView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
            ])
        let constraintRootViewHeight = rootView.heightAnchor.constraint(equalToConstant: 340)
        constraintRootViewHeight.priority = .init(999)
        constraintRootViewHeight.isActive = true
        
        NSLayoutConstraint.activate([
            articlePhoto.topAnchor.constraint(equalTo: rootView.topAnchor),
            articlePhoto.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            articlePhoto.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            articlePhoto.heightAnchor.constraint(equalToConstant: 217)
            ])
        
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: articlePhoto.bottomAnchor, constant: 8),
            articleTitle.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 16.7),
            articleTitle.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -50)
            ])
        
        NSLayoutConstraint.activate([
            articleText.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 5),
            articleText.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 16.7),
            articleText.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -50)
            ])
        
        NSLayoutConstraint.activate([
            stackForPublished.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -9),
            stackForPublished.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 16.7)
            ])
        
        NSLayoutConstraint.activate([
            stackForShares.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -9),
            stackForShares.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -16.7)
            ])
        
        NSLayoutConstraint.activate([
            publishedImage.heightAnchor.constraint(equalToConstant: 16),
            publishedImage.widthAnchor.constraint(equalToConstant: 16)
            ])
        
        NSLayoutConstraint.activate([
            shareImage.heightAnchor.constraint(equalToConstant: 16),
            shareImage.widthAnchor.constraint(equalToConstant: 16)
            ])
        
        NSLayoutConstraint.activate([
            categoryText.topAnchor.constraint(equalTo: categoryTextContainer.topAnchor),
            categoryText.bottomAnchor.constraint(equalTo: categoryTextContainer.bottomAnchor),
            categoryText.leadingAnchor.constraint(equalTo: categoryTextContainer.leadingAnchor, constant: 8),
            categoryText.trailingAnchor.constraint(equalTo: categoryTextContainer.trailingAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate([
            categoryTextContainer.heightAnchor.constraint(equalToConstant: 21)
            ])

        NSLayoutConstraint.activate([
            stackForCategory.bottomAnchor.constraint(equalTo: articlePhoto.bottomAnchor, constant: -9),
            stackForCategory.leadingAnchor.constraint(equalTo: articlePhoto.leadingAnchor, constant: 16)
            ])
    }
    
    func setMainPicture(image: String){
        let url = URL(string: constants.baseUrl + image)
        articlePhoto.kf.setImage(with:url)
    }
    
    func setCameraImage(){
        self.videoImageContainer.addSubview(videoImage)
        self.stackForCategory.addArrangedSubview(videoImageContainer)
        
        NSLayoutConstraint.activate([
            videoImage.topAnchor.constraint(equalTo: videoImageContainer.topAnchor, constant: 4),
            videoImage.leadingAnchor.constraint(equalTo: videoImageContainer.leadingAnchor, constant: 8),
            videoImage.trailingAnchor.constraint(equalTo: videoImageContainer.trailingAnchor, constant: -6),
            videoImage.bottomAnchor.constraint(equalTo: videoImageContainer.bottomAnchor, constant: -4)
            ])
    }
    
    func setGalleryImage(){
        self.galleryImageContainer.addSubview(galleryImage)
        self.stackForCategory.addArrangedSubview(galleryImageContainer)
        
        NSLayoutConstraint.activate([
            galleryImage.topAnchor.constraint(equalTo: galleryImageContainer.topAnchor, constant: 4),
            galleryImage.leadingAnchor.constraint(equalTo: galleryImageContainer.leadingAnchor, constant: 8),
            galleryImage.trailingAnchor.constraint(equalTo: galleryImageContainer.trailingAnchor, constant: -6),
            galleryImage.bottomAnchor.constraint(equalTo: galleryImageContainer.bottomAnchor, constant: -4)
            ])
    }
}
