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
        categoryText.backgroundColor = .red
        categoryText.layer.cornerRadius = 3
        categoryText.layer.masksToBounds = true
        categoryText.textAlignment = .justified
        return categoryText
    }()
    
    let relatedTitle: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.init(name: "Roboto-Bold", size: 14)
        text.isScrollEnabled = false
        return text
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
        self.contentView.addSubview(separator)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            relatedImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            relatedImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            relatedImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            relatedImage.widthAnchor.constraint(equalToConstant: 112),
            relatedImage.heightAnchor.constraint(equalToConstant: 112)
            ])
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: self.relatedImage.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            separator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
        let articleSeparatorHeight = separator.heightAnchor.constraint(equalToConstant: 1)
        articleSeparatorHeight.priority = .init(999)
        articleSeparatorHeight.isActive = true
    }
    
    func setImage(image: String){
        let url = URL(string: constants.baseUrl + image)
        relatedImage.kf.setImage(with:url)
    }
}
