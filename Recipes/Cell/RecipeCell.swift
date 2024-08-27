//
//  RecipeCell.swift
//  Recipes
//
//  Created by Batuhan Berk Ertekin on 27.08.2024.
//

import UIKit
import Kingfisher

class RecipeCell: UITableViewCell {

    static let identifier = "recipeCell"
    
    private var recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private  var recipeTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(recipeImage)
        addSubview(recipeTitle)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    
    func configure(with recipe: RecipeResult) {
        recipeTitle.text = recipe.title
        
        if let imageURL = URL(string: recipe.image) {
            recipeImage.kf.setImage(with: imageURL)
        } else {
            recipeImage.image = UIImage(named: "placeholderImage")
        }
    }
   
    func setImageConstraints() {
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            recipeImage.heightAnchor.constraint(equalToConstant: 100),
            recipeImage.widthAnchor.constraint(equalTo: recipeImage.heightAnchor, multiplier: 16/9)
        ])
    }

    func setTitleLabelConstraints() {
        recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            recipeTitle.leadingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: 12),
            recipeTitle.heightAnchor.constraint(equalToConstant: 80),
            recipeTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
           
        ])
    }
    
}
