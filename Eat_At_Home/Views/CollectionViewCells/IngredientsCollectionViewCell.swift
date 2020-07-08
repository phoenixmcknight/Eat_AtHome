//
//  IngredientsCollectionViewCell.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 7/6/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
   
    lazy var ingredientImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "photo")
        return image
    }()
    
    lazy var ingredientLabel:UILabel = {
        let label = UILabel(text: "Ingredient", fontsize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubviews()
        configureIngredientImageView()
        configureIngredientLabel()
       
        
    }
    
    private func addSubviews() {
        self.addSubview(ingredientImageView)
        self.addSubview(ingredientLabel)
    }
    
    func configureCell(with ingredient:Ingredients?) {
        guard let ingredient = ingredient else {return}
        
        if let cachedcImage =  ImageHelper.shared.image(forKey: ingredient.image as NSString)  {
            ingredientImageView.image = cachedcImage
        } else {
            
            
            ImageHelper.shared.getImage(urlStr: SpoonAPIClient.client.getIngredientImageURL(ingredientName: ingredient.image)) {
                [weak self](result) in
                DispatchQueue.main.async {
                    
                
                switch result {
                case .failure(_):
                    self?.ingredientImageView.image = UIImage(systemName: "photo")
                case .success(let image):
                    self?.ingredientImageView.image = image
                }
            }
            }
            ingredientLabel.text = ingredient.localizedName.capitalized
        }
    }
    
    private func configureIngredientImageView() {
        ingredientImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
           ingredientImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ingredientImageView.topAnchor.constraint(equalTo: self.topAnchor),
            ingredientImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
        ])
    }
    private func configureIngredientLabel() {
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ingredientLabel.topAnchor.constraint(equalTo: ingredientImageView.bottomAnchor),
            ingredientLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ingredientLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ingredientLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
